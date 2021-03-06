﻿
#Область ПрограммныйИнтерфейс_Алгоритмы

Процедура ВыполнитьПроцедуру(ПредставлениеАлгоритма,ВходящиеПараметры=Неопределено,ОшибкаВыполнения = Ложь,СообщениеОбОшибке = "")Экспорт
	// для совместимости со старыми версиями
	ВыполнитьФункцию(ПредставлениеАлгоритма,ВходящиеПараметры,ОшибкаВыполнения,СообщениеОбОшибке);
КонецПроцедуры 

Функция ВыполнитьФункцию(ПредставлениеАлгоритма, ВходящиеПараметры=Неопределено, ОшибкаВыполнения = Ложь,СообщениеОбОшибке = "") Экспорт
	
	УдалятьПослеВыполнения = Ложь;
	
	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда 
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		Иначе
			this = Новый Соответствие;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура();
		this = Новый Соответствие;
	КонецЕсли;
	
	// Для БСП ПодключаемыеКоманды
	// при добавлении команд возникает ошибка передачи контекста формы  ВходящиеПараметры.ПараметрВыполненияКоманды
	// поэтому добавляем после их после обработки на сервере 
	_ПараметрВыполненияКоманды = Неопределено;
	
	Если ВходящиеПараметры.Свойство("ПараметрВыполненияКоманды") Тогда
		
		_ПараметрВыполненияКоманды = ВходящиеПараметры["ПараметрВыполненияКоманды"];
		ВходящиеПараметры["ПараметрВыполненияКоманды"] = Неопределено;
		
	КонецЕсли;
	
	Если ТипЗнч(ПредставлениеАлгоритма) = Тип("Структура") 
		И ПредставлениеАлгоритма.Свойство("Параметры") Тогда
			//" переданы готовые настройки алгоритма например из таблицы команд  "
		
		СвойстваАлгоритма = ПредставлениеАлгоритма;
		
	Иначе
		
		Если ЭтоАдресВременногоХранилища(ПредставлениеАлгоритма) Тогда
			//" переданы адрес настроек  "
			
			АдресХранилища  = ПредставлениеАлгоритма;
			
		Иначе
			//" передана ссылка на алгоритм или наименование "
		
			АдресХранилища  = _37583_АлгоритмыСервер.ПолучитьСтруктуруВыполненияНаКлиенте(ПредставлениеАлгоритма, ВходящиеПараметры);
			
		КонецЕсли;
		
		СвойстваАлгоритма  = ПолучитьИзВременногоХранилища(АдресХранилища);
		
		УдалятьПослеВыполнения = Истина;
		
		Если ТипЗнч(СвойстваАлгоритма) = Тип("Структура") Тогда
			
			Если  СвойстваАлгоритма.Свойство("Параметры") = Ложь  Тогда
				
				ОшибкаВыполнения = Истина;
				ВызватьИсключение СвойстваАлгоритма.СообщениеОбОшибке;
				
			КонецЕсли;
			
		Иначе 
			
			ОшибкаВыполнения = Истина;
			СообщениеОбОшибке =  СтрШаблон(
			НСтр("ru = 'данные алгоритма  ""%1"" не определены.'"),
			ПредставлениеАлгоритма);
			ВызватьИсключение СообщениеОбОшибке;
			
		КонецЕсли;
		
		
	КонецЕсли;

	
	Параметры = СвойстваАлгоритма.Параметры;
	
	Если Не Параметры.Отказ Тогда
		
		// Добавляем _ПараметрВыполненияКоманды если  это клиентская команда
		Если _ПараметрВыполненияКоманды <> Неопределено Тогда 
			Параметры.Вставить("ПараметрВыполненияКоманды",_ПараметрВыполненияКоманды);
		КонецЕсли;
		
		Попытка
			Выполнить Параметры.КодАлгоритма;
		Исключение
			ОшибкаВыполнения = Истина;
			СообщениеОбОшибке = "Ошибка выпонения : "+ОписаниеОшибки() + ";";
			Параметры.Вставить("СообщениеОбОшибке", СообщениеОбОшибке);
			Параметры.Вставить("Отказ", Истина);
			_37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации("37583_ALG (&НаКлиенте) " + ПредставлениеАлгоритма,СообщениеОбОшибке);
			Если СвойстваАлгоритма.ВыбрасыватьИсключение Тогда
				ВызватьИсключение СообщениеОбОшибке; 
			КонецЕсли;
		КонецПопытки;
	Иначе 
		PopUp(Параметры.СообщениеОбОшибке);
	КонецЕсли;
	
	Если УдалятьПослеВыполнения = Истина Тогда
		
		УдалитьИзВременногоХранилища(АдресХранилища);
		
	КонецЕсли;
	
	Возврат this;
	
КонецФункции

#КонецОбласти

#Область ПрограммныйИнтерфейс_СообщенияДляПользователя

Процедура PopUp(ТекстСообщения ,Заголовок = Неопределено, СтатусВажное = Истина) Экспорт
    Если Не Заголовок = Неопределено Тогда
        ПоказатьОповещениеПользователя(Заголовок,,ТекстСообщения,БиблиотекаКартинок._37583_Робот,?(СтатусВажное,СтатусОповещенияПользователя.Важное,СтатусОповещенияПользователя.Информация));
    Иначе
        // чтобы не было скучно )
        мСообщений = Новый Массив;
        мСообщений.Добавить(" Есть ошибки ...");
        мСообщений.Добавить(" Ошибочка  ...");
        мСообщений.Добавить(" WTF ...");
        мСообщений.Добавить(" Не ошибается тот , кто не делает ...");
        мСообщений.Добавить(" Опять ошибка ...");
        мСообщений.Добавить(" Никогда не было и вот опять ...");
        мСообщений.Добавить(" Zzzzzzzzzz ...");
        мСообщений.Добавить(" Эммм ...");
        мСообщений.Добавить(" Что за ...");
        
        гсч = Новый ГенераторСлучайныхЧисел();
        ранд = гсч.СлучайноеЧисло(0,мСообщений.Количество()-1);
        ПоказатьОповещениеПользователя(мСообщений[ранд],,">>> " + ТекстСообщения,БиблиотекаКартинок._37583_Робот,?(СтатусВажное,СтатусОповещенияПользователя.Важное,СтатусОповещенияПользователя.Информация));
    КонецЕсли;
КонецПроцедуры

Процедура ПоказатьОповещениеСДействием(Заголовок,ТекстОповещения,ДополнительныеПараметры) Экспорт
    Если ДополнительныеПараметры.Свойство("Объект") И  ДополнительныеПараметры.Свойство("Код") Тогда
        ОписаниеОповещения = Новый ОписаниеОповещения("ВыполнитьЗавершение", ЭтотОбъект, ДополнительныеПараметры);
        ПоказатьОповещениеПользователя(Заголовок,ОписаниеОповещения,ТекстОповещения,БиблиотекаКартинок._37583_Робот,СтатусОповещенияПользователя.Информация);
    КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// завершение асинхронных процедур
Процедура ВыполнитьЗавершение(Результат, ДополнительныеПараметры) Экспорт
    Если Не ДополнительныеПараметры.Свойство("АлгоритмЗавершение") Тогда 
        Возврат;
    Иначе
        ДополнительныеПараметры.Вставить("РезультатЗавершение",Результат);
        ВыполнитьФункцию(ДополнительныеПараметры.АлгоритмЗавершение, ДополнительныеПараметры);
    КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// Обработчик команды формы.
//
// Параметры:
//   Форма - УправляемаяФорма - Форма, из которой выполняется команда.
//   Команда - КомандаФормы - Выполняемая команда.
//   Источник - ТаблицаФормы, ДанныеФормыСтруктура - Объект или список формы с полем "Ссылка".
//
Процедура ВыполнитьКоманду(Форма, Команда, Источник) Экспорт
	
	ИмяКоманды = Команда.Имя;
	
	ПараметрыПодключаемыхКоманд = Форма.ПараметрыПодключаемыхКоманд;
	
	Если  ПараметрыПодключаемыхКоманд.Свойство("АдресаКоманд_37583") = Ложь Тогда 
		
		АдресНастроек = ПараметрыПодключаемыхКоманд.АдресТаблицыКоманд;
		// записывает в ПараметрыПодключаемыхКоманд  Свойство "АдресаКоманд_37583"  - уид формы
		// Записывает данные подключаемых команд в соответствие (ИмяКоманды(строка), СвойстваАлгоритма(структ.)
		
		_37583_АлгоритмыСервер.ПолучитьСтруктуруВыполненияКомандыНаКлиенте(ПараметрыПодключаемыхКоманд, АдресНастроек);
		
	КонецЕсли;
	
	СвойстваАлгоритма = ПараметрыПодключаемыхКоманд.АдресаКоманд_37583[ИмяКоманды];
	
	СвойстваАлгоритма.Параметры.Вставить("Источник", Источник);
	
	СвойстваАлгоритма.Параметры.Вставить("Форма", Форма);
	
	ВыполнитьФункцию(СвойстваАлгоритма);
	
КонецПроцедуры

#КонецОбласти


