﻿Перем __итератор__;
Перем this;

#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьПараметры()Экспорт
	Параметры = Хранилище.Получить();
	Если Параметры = Неопределено ИЛИ ТипЗнч(Параметры) <> Тип("Структура")Тогда 
		Параметры =  Новый Структура;
	КонецЕсли;
	Возврат Параметры;
КонецФункции

Функция ПолучитьПараметр(НаименованиеПараметра) Экспорт
	Параметры = Хранилище.Получить();
	Если Параметры <> Неопределено И Параметры.Свойство(НаименованиеПараметра) Тогда
		Возврат Параметры[НаименованиеПараметра];
	Иначе 
		Возврат Неопределено;
	КонецЕсли;
КонецФункции 

Процедура ИзменитьПараметр(НовыеДанные) Экспорт
	Попытка
		НаименованиеПараметра = НовыеДанные.НаименованиеПараметра;
		Если ТипЗнч(НовыеДанные.ЗначениеПараметра) = Тип("Строка")Тогда
			Если Лев(НовыеДанные.ЗначениеПараметра,1) = "{" Тогда
				Поз = СтрНайти(НовыеДанные.ЗначениеПараметра,"}");
				Если Поз > 0  Тогда
					АдресХранилища = Сред(НовыеДанные.ЗначениеПараметра, Поз+1);
					ЗначениеПараметра = ПолучитьИЗВременногоХранилища(АдресХранилища);
					РасширениеФайла = СтрЗаменить(Сред(НовыеДанные.ЗначениеПараметра,2,Поз-2),Символ(32),""); 
					НаименованиеПараметра = "Файл"+ВРег(РасширениеФайла)+"_"+НаименованиеПараметра;
				Иначе 
					Если ВыбрасыватьИсключение Тогда 
						ВызватьИсключение "Ошибка при чтении Файла из хранилища "; 
					КонецЕсли;
				КонецЕсли;
			Иначе
				ЗначениеПараметра = НовыеДанные.ЗначениеПараметра;
			КонецЕсли;
		Иначе
			ЗначениеПараметра = НовыеДанные.ЗначениеПараметра;
		КонецЕсли;
		ПараметрыОбъекта = Хранилище.Получить();
		Если ПараметрыОбъекта  =  Неопределено ИЛИ ТипЗнч(ПараметрыОбъекта) <>  Тип("Структура")Тогда
			ПараметрыОбъекта =  Новый Структура;
		КонецЕсли;
		ПараметрыОбъекта.Вставить(НаименованиеПараметра,ЗначениеПараметра);
		Хранилище = Новый ХранилищеЗначения(ПараметрыОбъекта);
		Записать();
	Исключение
		ЗаписатьОшибку("Изменение параметра");
		Если ВыбрасыватьИсключение Тогда
			ВызватьИсключение ; 
		КонецЕсли;
	КонецПопытки;
КонецПроцедуры

Функция УдалитьПараметр(Ключ) Экспорт
	Попытка
		Параметры = ПолучитьПараметры();
		Параметры.Удалить(Ключ);
		Хранилище = Новый ХранилищеЗначения(Параметры);
		Записать();
		Возврат Истина;	
	Исключение
		ЗаписатьОшибку("Удаление параметра");
		Возврат Ложь;
	КонецПопытки;
КонецФункции

Функция ПереименоватьПараметр(Ключ,НовИмя) Экспорт
	Попытка
		ПараметрыОбъекта = ПолучитьПараметры();
		Значение = ПараметрыОбъекта[Ключ];
		ПараметрыОбъекта.Удалить(Ключ);
		ПараметрыОбъекта.Вставить(НовИмя,Значение);
		Хранилище = Новый ХранилищеЗначения(ПараметрыОбъекта);
		Записать();
		Возврат Истина;
	Исключение
		ЗаписатьОшибку("Переименование параметра");
		Возврат Ложь;
	КонецПопытки;
КонецФункции 

Процедура ВыполнитьПроцедуру(ВходящиеПараметры = Неопределено) Экспорт
	//оставлено для совместимости со старыми версиями
	ВыполнитьФункцию(ВходящиеПараметры);
КонецПроцедуры

Функция ВыполнитьФункцию(ВходящиеПараметры = Неопределено) Экспорт
	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда 
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура();
	КонецЕсли;
	ВыполнитьАлгоритм (ВходящиеПараметры);
	Возврат this;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПодключитьДекораторы(ПараметрыАлгоритма) Экспорт
	Для Каждого Элемент Из Декораторы Цикл
		Если Элемент.Декоратор = Ссылка Или Элемент.Декоратор.Пустая() Тогда
			Продолжить;
		КонецЕсли;
		_37583_АлгоритмыСервер.ВыполнитьПроцедуру(Элемент.Декоратор,Новый Структура("Параметры",ПараметрыАлгоритма));
	КонецЦикла;
КонецПроцедуры

Процедура ВыполнитьАлгоритм (Параметры)
	
	Если Не Параметры.Свойство("СообщениеОбОшибке") Тогда
		Параметры.Вставить("СообщениеОбОшибке",""); 
	КонецЕсли;
	
	Если Не Параметры.Свойство("Отказ") Тогда
		Параметры.Вставить("Отказ",Ложь); 
	КонецЕсли;
	
	Если ТолькоТекст Тогда
		ХранимыеПараметры = Новый Структура;
	Иначе
		ХранимыеПараметры = ПолучитьПараметры();
	КонецЕсли;	
	
	Для Каждого ХранимыйПараметр Из ХранимыеПараметры Цикл
		Если Не Параметры.Свойство(ХранимыйПараметр.Ключ) Тогда 
			Параметры.Вставить(ХранимыйПараметр.Ключ,ХранимыйПараметр.Значение);
		КонецЕсли;
	КонецЦикла;
	
	// закроем выполнение  произвольного кода 
	Параметры.Вставить("КодАлгоритма",КодАлгоритма) ;  
	
	//@Decorate
	ПодключитьДекораторы(Параметры);
	
	// устанавливаем "глобальный контекст"
	
	__итератор__ = 0;
	
	Если Не Параметры.Отказ Тогда
		
		ВыполнитьЛокальныйКонтекст(Параметры);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьЛокальныйКонтекст(Параметры)
	
	Если __итератор__>РазмерСтека Тогда
		Параметры.Вставить("Отказ",Истина);
		Параметры.Вставить("СообщениеОбОшибке","Переполнение  стека");
		ЗаписатьОшибку("Переполнение  стека");
		Возврат;
	КонецЕсли;    
	__итератор__ = __итератор__ + 1;
	Если ВыполнитьВТранзакции Тогда
		НачатьТранзакцию();
		Попытка
			Выполнить(Параметры.КодАлгоритма);
			ЗафиксироватьТранзакцию();
			Если ЗаписыватьСобытиияВЖР  Тогда 
				ЗаписатьСобытие();    
			КонецЕсли;
		Исключение
			Если ТранзакцияАктивна() Тогда
				ОтменитьТранзакцию();
			КонецЕсли;
			ОбработатьОшибку(Параметры, ОписаниеОшибки());
		КонецПопытки;
	Иначе
		Попытка
			Выполнить(Параметры.КодАлгоритма);
			Если ЗаписыватьСобытиияВЖР  Тогда
				ЗаписатьСобытие();
			КонецЕсли;
		Исключение
			ОбработатьОшибку(Параметры, ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры // ВыполнитьЛокальныйКонтекст()

Процедура ОбработатьОшибку(Параметры, ОписаниеОшибки)
	СообщениеОбОшибке = " Ошибка выполнения : "+ОписаниеОшибки + ";";
	Параметры.Вставить("СообщениеОбОшибке", СообщениеОбОшибке);
	Параметры.Вставить("Отказ", Истина);
	Если ЗаписыватьОшибкиВЖР  Тогда 
		ЗаписатьОшибку(Параметры.СообщениеОбОшибке);    
	КонецЕсли;
	Если ВыбрасыватьИсключение Тогда 
		ВызватьИсключение СообщениеОбОшибке; 
	КонецЕсли;
КонецПроцедуры

Процедура ЗаписатьСобытие(Текст="")
	коммент = ?(ПустаяСтрока(Текст),Наименование,"<"+Наименование+">: "+Текст);
	_37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации("37583_ALG (&НаСервере)",коммент,?(ЭтоНовый(),"",Ссылка),"Информация");
КонецПроцедуры

Процедура ЗаписатьОшибку(Текст="")
	коммент = ?(ПустаяСтрока(Текст),"<"+Наименование+">: ","<"+Наименование+">:-  "+ Текст);
	_37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации("37583_ALG (&НаСервере)", коммент);
КонецПроцедуры


#КонецОбласти

__итератор__ = 0;
this =  Новый Соответствие;




