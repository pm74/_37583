﻿&НаСервереБезКонтекста
Функция ИмяМетаданных(ПолноеИмя)
	
	Возврат СтрПолучитьСтроку(СтрЗаменить(ПолноеИмя, ".", Символы.ПС), 1);
	
КонецФункции

&НаСервереБезКонтекста
Функция ОбъектМетаданныхИмеетСтандартныеРеквизиты(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("Документ");
	Объекты.Добавить("БизнесПроцесс");
	Объекты.Добавить("Задача");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

&НаСервереБезКонтекста
Функция ОбъектМетаданныхИмеетИзмерения(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("РегистрСведений");
	Объекты.Добавить("РегистрНакопления");
	Объекты.Добавить("РегистрБухгалетрии");
	Объекты.Добавить("РегистрРасчета");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

&НаСервереБезКонтекста
Функция ОбъектМетаданныхИмеетТЧ(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("Документ");
	Объекты.Добавить("Отчет");
	Объекты.Добавить("Обработка");
	Объекты.Добавить("БизнесПроцесс");
	Объекты.Добавить("Задача");
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

&НаСервереБезКонтекста
Функция ОбъектМетаданныхИмеетПредопределенные(ПолноеИмя)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("ПланСчетов");	
	
	Возврат Объекты.Найти(ИмяМетаданных(ПолноеИмя)) <> Неопределено;
	
КонецФункции

&НаСервере
Функция ОписатьКоллекциюОбъектовМетаданых(Коллекция)
	
	ОписаниеКоллекции = Новый Структура();
	
	Для НомерОбъекта = 0 По Коллекция.Количество() - 1 Цикл
		
		ОписаниеРеквизитов = Новый Структура();
		ОписаниеПредопределенных = Новый Структура();
		
		ОбъектМетаданных = Коллекция.Получить(НомерОбъекта);		
		ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		Если ИмяМетаданных(ПолноеИмя) = "Перечисление" Тогда
			
			Для НомерРеквизита = 0 По ОбъектМетаданных.ЗначенияПеречисления.Количество() - 1 Цикл
				Реквизит = ОбъектМетаданных.ЗначенияПеречисления.Получить(НомерРеквизита);
				ОписаниеРеквизитов.Вставить(Реквизит.Имя, Реквизит.Синоним);
			КонецЦикла;
			
		Иначе
			
			Для НомерРеквизита = 0 По ОбъектМетаданных.Реквизиты.Количество() - 1 Цикл
				Реквизит = ОбъектМетаданных.Реквизиты.Получить(НомерРеквизита);
				ОписаниеРеквизитов.Вставить(Реквизит.Имя, Реквизит.Синоним);
			КонецЦикла;
			
			Если ОбъектМетаданныхИмеетСтандартныеРеквизиты(ПолноеИмя) Тогда
				
				Для Каждого Реквизит ИЗ ОбъектМетаданных.СтандартныеРеквизиты Цикл
					ОписаниеРеквизитов.Вставить(Реквизит.Имя, Реквизит.Синоним);
				КонецЦикла;
				
			КонецЕсли;
			
			Если ОбъектМетаданныхИмеетПредопределенные(ПолноеИмя) Тогда
				
				Предопределенные = ОбъектМетаданных.ПолучитьИменаПредопределенных();
				
				Для Каждого Имя ИЗ Предопределенные Цикл
					ОписаниеПредопределенных.Вставить(Имя, "");
				КонецЦикла;
				
			КонецЕсли;
			
			Если ОбъектМетаданныхИмеетИзмерения(ПолноеИмя) Тогда
				
				Для НомерРеквизита = 0 По ОбъектМетаданных.Измерения.Количество() - 1 Цикл
					Реквизит = ОбъектМетаданных.Измерения.Получить(НомерРеквизита);
					ОписаниеРеквизитов.Вставить(Реквизит.Имя, Реквизит.Синоним);
				КонецЦикла;
				
				Для НомерРеквизита = 0 По ОбъектМетаданных.Ресурсы.Количество() - 1 Цикл
					Реквизит = ОбъектМетаданных.Ресурсы.Получить(НомерРеквизита);
					ОписаниеРеквизитов.Вставить(Реквизит.Имя, Реквизит.Синоним);
				КонецЦикла;
				
			КонецЕсли;
			
			Если ОбъектМетаданныхИмеетТЧ(ПолноеИмя) Тогда
				
				Для НомерРеквизита = 0 По ОбъектМетаданных.ТабличныеЧасти.Количество() - 1 Цикл
					Реквизит = ОбъектМетаданных.ТабличныеЧасти.Получить(НомерРеквизита);
					ОписаниеРеквизитов.Вставить(Реквизит.Имя, "ТЧ: " + Реквизит.Синоним);
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЕсли;
		
		СтруктураОбъекта = Новый Структура("properties", ОписаниеРеквизитов);
		Если 0 < ОписаниеПредопределенных.Количество() Тогда
			СтруктураОбъекта.Вставить("predefined", ОписаниеПредопределенных); 
		КонецЕсли;				
		
		ОписаниеКоллекции.Вставить(ОбъектМетаданных.Имя, СтруктураОбъекта);
		
	КонецЦикла;
	
	Возврат ОписаниеКоллекции;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьКоллекциюМетаданныхНаСервере()
	
	КоллекцияМетаданных = Новый Структура();
	КоллекцияМетаданных.Вставить("catalogs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Справочники));
	КоллекцияМетаданных.Вставить("documents", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Документы));
	КоллекцияМетаданных.Вставить("infoRegs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.РегистрыСведений));
	КоллекцияМетаданных.Вставить("accumRegs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.РегистрыНакопления));
	КоллекцияМетаданных.Вставить("accountRegs", ОписатьКоллекциюОбъектовМетаданых(Метаданные.РегистрыБухгалтерии));
	КоллекцияМетаданных.Вставить("dataProc", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Обработки));
	КоллекцияМетаданных.Вставить("reports", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Отчеты));
	КоллекцияМетаданных.Вставить("enums", ОписатьКоллекциюОбъектовМетаданых(Метаданные.Перечисления));
	
	АдресДанных = ПоместитьВоВременноеХранилище(КоллекцияМетаданных, Новый УникальныйИдентификатор());
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыводаОшибки(ДопПараметры) Экспорт
	
	ЗакрытьКонсоль();
	
КонецПроцедуры

&НаКлиенте
Процедура ВывестиОшибку(Текст)
	
	ПоказатьПредупреждение(Новый ОписаниеОповещения("ПослеВыводаОшибки", ЭтаФорма), Текст);	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьКоллекциюМетаданных()
	
	ЗаполнитьКоллекциюМетаданныхНаСервере();		
	HTML = КаталогИсходников + "index.html";
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписиФайлаМакета(ДопПараметры) Экспорт
	
	Попытка
		Файл = Новый ЧтениеZipФайла(КаталогИсходников + "bsl_console.zip");
		Файл.ИзвлечьВсе(КаталогИсходников);
		ЗаполнитьКоллекциюМетаданных();		
	Исключение
		ВывестиОшибку("Не удалось извлечь исходники" + Символы.ПС + ОписаниеОшибки());
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПроверкиСуществованияКаталога(Существует, ДопПараметры) Экспорт
	
	Если Существует Тогда
		ИмяФайла = КаталогИсходников + "bsl_console.zip";
		ДанныеМакета = ПолучитьИзВременногоХранилища(АдресДанных);
		ДанныеМакета.НачатьЗапись(Новый ОписаниеОповещения("ПослеЗаписиФайлаМакета", ЭтаФорма), ИмяФайла);
	Иначе		
		ВывестиОшибку("Не удалось создать каталог для исходников");		
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеСозданияКаталога(ИмяКаталога, ДопПараметры) Экспорт
	
	ФайлНаДиске = Новый Файл(КаталогИсходников);
	ФайлНаДиске.НачатьПроверкуСуществования(Новый ОписаниеОповещения("ПослеПроверкиСуществованияКаталога", ЭтаФорма));
	
КонецПроцедуры

&НаКлиенте
Процедура ПриПолученииКаталогаВременныхФайлов(ИмяКаталога, ДопПараметры) Экспорт
	
	КаталогИсходников = ИмяКаталога + "bsl_console\";
	НачатьСозданиеКаталога(Новый ОписаниеОповещения("ПослеСозданияКаталога", ЭтаФорма), КаталогИсходников);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзвлечьИсходники()
	
	НачатьПолучениеКаталогаВременныхФайлов(Новый ОписаниеОповещения("ПриПолученииКаталогаВременныхФайлов", ЭтаФорма));	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьПометкуТемы("СветлаяТема");
	
	Состояние("Инициализация...");	
	
	//  начало изменения pm74  23.07.2020 11:36:50
	
	Если  ПустаяСтрока(КаталогИсходников) Тогда
		
		ИзвлечьИсходники();
		
	Иначе 
		
		ПодключитьHTML();
		
	КонецЕсли;
	
	//  конец изменения pm74  23.07.2020 11:36:50
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкуТемы(Тема)
	
	Для Каждого Элемент ИЗ Элементы.Тема.ПодчиненныеЭлементы Цикл		
		Элемент.Пометка = (Элемент.Имя = Тема);		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключитьТему(Тема)
	
	Элементы.HTML.Документ.monaco.editor.setTheme(Тема);
	
КонецПроцедуры

&НаКлиенте
Процедура СветлаяТема(Команда)
	
	ПереключитьТему("bsl-white");
	УстановитьПометкуТемы(Команда.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура ТемнаяТема(Команда)
	
	ПереключитьТему("bsl-dark");
	УстановитьПометкуТемы(Команда.Имя);
	
КонецПроцедуры

&НаКлиенте
Функция View()
	
	Возврат Элементы.HTML.Документ.defaultView;
	
КонецФункции

&НаКлиенте
Процедура УстановитьТекст(Текст, Позиция)
	
	View().setText(Текст, Позиция);
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьТекст()
	
	Возврат View().getText();
	
КонецФункции

&НаКлиенте
Функция ОчиститьТекст()
	
	Возврат View().eraseText();
	
КонецФункции

&НаКлиенте
Процедура ПриЗакрытииКонструктораЗапросов(Текст, ДопПараметры) Экспорт
	
	Текст = СтрЗаменить(Текст, Символы.ПС, Символы.ПС + "|");
	
	Текст = """" + Текст + """";
	
	УстановитьТекст(Текст, ДопПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКонструкторЗапроса(Текст, ДопПараметры)
	
	Конструктор = Новый КонструкторЗапроса();
	Попытка			
		Конструктор.Текст = Текст;
	Исключение
		Инфо = ИнформацияОбОшибке();
		ПоказатьПредупреждение(, "Ошибка в тексте запроса:" + Символы.ПС + Инфо.Причина.Описание);
		Возврат;
	КонецПопытки;
	Оповещение = Новый ОписаниеОповещения("ПриЗакрытииКонструктораЗапросов", ЭтаФорма, ДопПараметры);
	Конструктор.Показать(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросСоздатьНовыйЗапрос(Ответ, ДопПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ОткрытьКонструкторЗапроса("", Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КонструкторЗапроса(Команда)
	
	match = View().getQuery();
	
	Если match = Неопределено Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ВопросСоздатьНовыйЗапрос", ЭтаФорма), "Не найден текст запроса." + Символы.ПС + "Создать новый запрос?", РежимДиалогаВопрос.ДаНет);
	Иначе
		ТекстЗапроса = СтрЗаменить(СтрЗаменить(match.text, "|", ""), """", "");
		ОткрытьКонструкторЗапроса(ТекстЗапроса, match.range);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьНаКлиенте(Команда)
	
	Выполнить(ПолучитьТекст());
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКодНаСервере(Текст)
	
	Выполнить(Текст);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьНаСервере(Команда)
	
	ВыполнитьКодНаСервере(ПолучитьТекст());
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	//  начало изменения pm74  23.07.2020 11:52:47
	
	Если Параметры.РежимРедакторАлгоритма  Тогда
		
		ТекстАлгоритма = Параметры.ТекстАлгоритма;
		НаКлиенте = Параметры.НаКлиенте;
		КаталогИсходников = Параметры.КаталогИсходников;
		РежимРедакторАлгоритма = Параметры.РежимРедакторАлгоритма;
		
	КонецЕсли;
	
	Если Не ПустаяСтрока(КаталогИсходников)  Тогда
		
		Если РежимРедакторАлгоритма = Ложь Тогда
			
			ЗаполнитьКоллекциюМетаданныхНаСервере();
			
		КонецЕсли;
		
	Иначе
		
		АдресДанных = ПоместитьВоВременноеХранилище(РеквизитФормыВЗначение("Объект").ПолучитьМакет("src"), УникальныйИдентификатор);
		
	КонецЕсли;
	
	//  конец изменения pm74  23.07.2020 11:52:47	
	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеУдаленияВременныхФайлов(ДопПараметры) Экспорт
	
	КаталогИсходников = "";
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьКонсоль(ПараметрЗакрытия = Неопределено)
	
	Если ЗначениеЗаполнено(КаталогИсходников) 
		//  начало изменения pm74  23.07.2020 12:32:13
		И  РежимРедакторАлгоритма = Ложь
		//  конец изменения pm74  23.07.2020 12:32:13
		Тогда
		
		НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияВременныхФайлов", ЭтаФорма), КаталогИсходников);
		
	Иначе
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы = Неопределено ИЛИ НЕ ЗавершениеРаботы Тогда
		
		Если ЗначениеЗаполнено(КаталогИсходников) 
			//  начало изменения pm74  23.07.2020 12:32:13
			И РежимРедакторАлгоритма = Ложь
			//  конец изменения pm74  23.07.2020 12:32:13
			Тогда
			
			Отказ = Истина;
			ЗакрытьКонсоль();
			
		КонецЕсли;
		
	Иначе
		
		ЗакрытьКонсоль();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииЧтенияФайлаМетаданных(ДопПараметры) Экспорт
	
	Результат = View().updateMetadata(ДопПараметры.Файл.ПолучитьТекст());
	
	Если ТипЗнч(Результат) <> Тип("Булево") Тогда
		ВывестиОшибку("Не удалось обновить метаданные: " + Символы.ПС + Результат.errorDescription);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьМетаданные()
	
	ДанныеЗаписаны = Ложь;
	
	КоллекцияМетаданных = ПолучитьИзВременногоХранилища(АдресДанных);
	
	ВремФайл = КаталогИсходников + "metadata.json";
	
	Файл = Новый ЗаписьJSON();
	Файл.ОткрытьФайл(ВремФайл);
	Попытка
		ЗаписатьJSON(Файл, КоллекцияМетаданных);
		ДанныеЗаписаны = Истина;
	Исключение
		ВывестиОшибку("Не удалось сохранить коллекцию метаданных:" + Символы.ПС + ОписаниеОшибки());					
	КонецПопытки;
	
	Файл.Закрыть();
	
	Если ДанныеЗаписаны Тогда
		Файл = Новый ТекстовыйДокумент();
		Файл.НачатьЧтение(Новый ОписаниеОповещения("ПриЗавершенииЧтенияФайлаМетаданных", ЭтаФорма, Новый Структура("Файл, ИмяФайла", Файл, ВремФайл)), ВремФайл, КодировкаТекста.UTF8);
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура HTMLДокументСформирован(Элемент)
	
	Элементы.КонструкторЗапроса.Доступность = Истина;
	Элементы.ВыполнитьНаКлиенте.Доступность = Истина;
	Элементы.ВыполнитьНаСервере.Доступность = Истина;
	Элементы.ЗагрузитьИзФайла.Доступность = Истина;
	Элементы.СохранитьВФайл.Доступность = Истина;
	Элементы.Тема.Доступность = Истина;
	Состояние("Получение метаданных...");
	
	//  начало изменения pm74  28.07.2020 0:29:03
	Если РежимРедакторАлгоритма = Ложь Тогда
		
		ОбновитьМетаданные();
		
	Иначе
		
		УстановитьТекстАлгоритма();
		ЗагрузитьДополненияАвтокомплита();
	
	КонецЕсли;
	//  конец изменения pm74  28.07.2020 0:29:03
	
КонецПроцедуры

&НаКлиенте
Процедура ПриВыбореФайлаДляСохранения(ВыбранныеФайлы, ДопПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		Файл = Новый ЗаписьТекста(ВыбранныеФайлы[0], КодировкаТекста.UTF8);
		Файл.Записать(ПолучитьТекст());
		Файл.Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииЧтенияФайлаСКодом(ДопПараметры) Экспорт
	
	ОчиститьТекст();
	УстановитьТекст(ДопПараметры.ПолучитьТекст(), Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриВыбореФайлаДляЗагрузки(ВыбранныеФайлы, ДопПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		Файл = Новый ТекстовыйДокумент();
		Файл.НачатьЧтение(Новый ОписаниеОповещения("ПриЗавершенииЧтенияФайлаСКодом", ЭтаФорма, Файл), ВыбранныеФайлы[0], КодировкаТекста.UTF8);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ЕстьКод()
	
	Возврат ЗначениеЗаполнено(СтрЗаменить(СокрЛП(ПолучитьТекст()), Символы.ПС, ""));
	
КонецФункции


&НаКлиенте
Процедура ВопросЗаменыКодомИзФайла(Ответ, ДопПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ЗагрузитьКодИзФайла();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзФайла(Команда)
	
	Если ЕстьКод() Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ВопросЗаменыКодомИзФайла", ЭтаФорма), "При загрузке из файла текущий код будет заменен. Всё равно продолжить?", РежимДиалогаВопрос.ДаНет);
	Иначе
		ЗагрузитьКодИзФайла();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаРедактора(Команда)
	
	View().editor.trigger("", Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаменитьВхождения(Команда)
	
	КомандаРедактора("editor.action.changeAll");
	
КонецПроцедуры



#Область ДобавленыеПроцедурыИФункции

&НаКлиенте
Процедура ПодключитьHTML()
	
	Попытка
		HTML = "file:///"+КаталогИсходников + "index.html";
	Исключение
		ВывестиОшибку(" Неудачная попытка извлечь исходники" + Символы.ПС + ОписаниеОшибки());
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекстАлгоритма()
	
	УстановитьТекст(ТекстАлгоритма, Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	
	ОписаниеОповещенияОЗакрытии.ДополнительныеПараметры.Вставить("ТекстАлгоритма", ПолучитьТекст());
	Закрыть();
	
КонецПроцедуры

&НаСервере
Функция СоздатьОписаниеАлгоритмов()
	
	ОписаниеПользовательскихФункций = Новый Структура(); // {
	
	ОписаниеСниппетов = Новый Структура();	// {
	
	Запрос = Новый Запрос;
	ТекстЗапроса ="ВЫБРАТЬ
	|	_37583_ALG.Ссылка КАК Ссылка,
	|	_37583_ALGПрограммныйИнтерфейс.Имя КАК ИмяПараметра,
	|	_37583_ALGПрограммныйИнтерфейс.ТипПараметра КАК ТипПараметра,
	|	_37583_ALGПрограммныйИнтерфейс.Вход КАК Входящий,
	|	_37583_ALG.Комментарий КАК Комментарий,
	|	_37583_ALG.Наименование КАК Наименование,
	|	_37583_ALGПрограммныйИнтерфейс.ЗначениеПоУмолчанию КАК ЗначениеПоУмолчанию
	|ИЗ
	|	Справочник._37583_ALG КАК _37583_ALG
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник._37583_ALG.ПрограммныйИнтерфейс КАК _37583_ALGПрограммныйИнтерфейс
	|		ПО _37583_ALG.Ссылка = _37583_ALGПрограммныйИнтерфейс.Ссылка
	|ИТОГИ
	|	Комментарий КАК Комментарий,
	|	Наименование КАК Наименование
	|ПО
	|	Ссылка";
	
	Если НаКлиенте = Ложь  Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"%1%"," ГДЕ _37583_ALGПрограммныйИнтерфейс.Ссылка.НаКлиенте = ЛОЖЬ");
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"%1%", "");
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	
	// { 
	// customfunctions : {
	customFunctions = Новый Структура; 
	
	// { 
	// 	 snippets: {
	snippets = Новый Структура; 
	
	
	Пока Выборка.Следующий() Цикл
		
		// шаблон заполнения сниппетов
		сн1 ="СтруктураПараметров = Новый Структура();"+Символы.ПС;
		сн2 = "Отказ = Ложь;
		|Р = __ф(""%1"",СтруктураПараметров,Отказ)#Результат;
		|Если Не Отказ Тогда
		|	${1:ВставкаКода}
		|КонецЕсли;";
		
		
		// { 
		//customfunctions: 
		// { МояФункция1: {
		МояФункция1 = Новый Структура; 
		
		НаименованиеФункции =Выборка.Наименование;
		ТрансНаименование = _37583_ОбщегоНазначенияКлиентСервер.Транслитерация(НаименованиеФункции);
		
		МояФункция1.Вставить("name", НаименованиеФункции + "_37583");
		МояФункция1.Вставить("name_en", ТрансНаименование + "_37583");
		МояФункция1.Вставить("description", Выборка.Комментарий);
		
		
		out  = "Тип: Соответствие ";
		
		out_descr = "";
		
		sep_out  = "";
		
		ВыборкаПараметров = Выборка.Выбрать();
		
		// { 
		//customfunctions: 
		// { МояФункция1: {
		// signature: {
		// default: {
		signature = Новый Структура;
		
		default = Новый Структура;
		
		in_descr = "";
		
		sep_in = "";
		
		ВходящиеПараметры = Новый Структура;
		
		Пока ВыборкаПараметров.Следующий() Цикл
			
			Если ВыборкаПараметров.ИмяПараметра = NUll Тогда   
				Продолжить;
			КонецЕсли;
			
			Если ВыборкаПараметров.Входящий = Ложь Тогда
				
				out_descr = sep_out + out_descr + ВыборкаПараметров.ИмяПараметра + ":" + ВыборкаПараметров.ТипПараметра;
				
				sep_out = ";";
				
			Иначе
				
				in_descr = sep_in + in_descr + ВыборкаПараметров.ИмяПараметра + ":" + ВыборкаПараметров.ТипПараметра;
				
				ВходящиеПараметры.Вставить(ВыборкаПараметров.ИмяПараметра,ВыборкаПараметров.ТипПараметра + "(" + ВыборкаПараметров.ЗначениеПоУмолчанию + ")" );
				
				сн1 = сн1 + "СтруктураПараметров.Вставить("""+ВыборкаПараметров.ИмяПараметра+""",${0:ОписаниеПараметра});"+Символы.ПС;
				
			КонецЕсли;
			
		КонецЦикла;
		
		// функции 
		
		default.Вставить("СтрокаПараметров", "(" + in_descr + ")"); 
		
		default.Вставить("Параметры", ВходящиеПараметры); 
		
		signature.Вставить("default", default);
		
		МояФункция1.Вставить("returns", out + "(" + out_descr + ")");
		
		МояФункция1.Вставить("signature", signature);
		
		НаименованиеФункции = _37583_ОбщегоНазначенияКлиентСервер.СклеитьСтроку(Выборка.Наименование); 
		
		customFunctions.Вставить(НаименованиеФункции, МояФункция1);
		
		// сниппеты
		КомметнарийСнипета = "///" + Выборка.Комментарий + Символы.ПС;
		СодержимоеСниппета = Новый Структура;
		СодержимоеСниппета.Вставить("prefix","_ф."+НаименованиеФункции);
		СодержимоеСниппета.Вставить("body", КомметнарийСнипета + сн1 + СтрШаблон(сн2,НаименованиеФункции));
		СодержимоеСниппета.Вставить("description","IN: (" + in_descr + ")\nOUT: (" + out_descr + ")\n"+ Выборка.Комментарий);
		
		snippets.Вставить(НаименованиеФункции,СодержимоеСниппета);
		
	КонецЦикла;
	
	ОписаниеПользовательскихФункций.Вставить("customFunctions", customFunctions);
	
	ОписаниеСниппетов.Вставить("snippets",snippets);
	
	ЗаписьJSON = Новый ЗаписьJSON; 
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет);
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON); 
	ЗаписатьJSON(ЗаписьJSON, ОписаниеПользовательскихФункций); 
	СтрокаJSON_ПользовательскихФункций  = ЗаписьJSON.Закрыть();
	
	ЗаписьJSON = Новый ЗаписьJSON; 
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет);
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON); 
	ЗаписатьJSON(ЗаписьJSON, ОписаниеСниппетов); 
	СтрокаJSON_Сниппетов  = ЗаписьJSON.Закрыть();
	
	
	Возврат Новый Структура("СтрокаJSON_ПФ,СтрокаJSON_СН",СтрокаJSON_ПользовательскихФункций,СтрокаJSON_Сниппетов) ;
	
КонецФункции

&НаКлиенте
Процедура ЗагрузитьОписаниеАлгоритмов(Команда)
	
	СтруктураJSON = СоздатьОписаниеАлгоритмов();
	
	Результат1 = View().updateCustomFunctions(СтруктураJSON.СтрокаJSON_ПФ);
	
	Результат2 = View().updateSnippets(СтруктураJSON.СтрокаJSON_СН);
	
	Результат = Результат1 И Результат2;
	
	Если ТипЗнч(Результат) = Тип("Булево") Тогда
		Сообщить("Описания алгоритмов успешно загружены!", СтатусСообщения.Информация);
	Иначе
		ВывестиОшибку("Не удалось загрузить описания алгоритмов: " + Символы.ПС + Результат.errorDescription);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьДополненияАвтокомплита()
	
	ЗагрузитьОписаниеАлгоритмов(Неопределено);
	
КонецПроцедуры

#КонецОбласти 

#Область СкрытыеЭлементы

&НаКлиенте
Процедура СохранитьВФайл(Команда)
	
	Если ЕстьКод() Тогда
		ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
		ДиалогВыбора.Фильтр = "BSL|*.bsl";
		ДиалогВыбора.Показать(Новый ОписаниеОповещения("ПриВыбореФайлаДляСохранения", ЭтаФорма));
	Иначе
		ПоказатьПредупреждение(, "Нет кода для сохранения!");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьКодИзФайла()
	
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбора.Фильтр = "BSL|*.bsl";	
	ДиалогВыбора.Показать(Новый ОписаниеОповещения("ПриВыбореФайлаДляЗагрузки", ЭтаФорма));
	
КонецПроцедуры

#КонецОбласти 

#Область Обновления

// UPD Start 28.07.2020

&НаКлиенте
Процедура ЗагрузитьСниппеты(Команда)
	
	СтрокаJSON = ПолучитьТекстМакета("ПользовательскиеСниппеты");
	
	Результат = View().updateSnippets(СтрокаJSON);
	
	Если ТипЗнч(Результат) = Тип("Булево") Тогда
		Сообщить("Пользовательские сниппеты успешно загружены!", СтатусСообщения.Информация);
	Иначе
		ВывестиОшибку("Не удалось загрузить сниппеты: " + Символы.ПС + Результат.errorDescription);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ЗагрузитьПользовательскиеФункции(Команда)
	
	СтрокаJSON = ПолучитьТекстМакета("ПользовательскиеФункции");
	Результат = View().updateCustomFunctions(СтрокаJSON);
	
	Если ТипЗнч(Результат) = Тип("Булево") Тогда
		Сообщить("Пользовательские функции успешно загружены!", СтатусСообщения.Информация);
	Иначе
		ВывестиОшибку("Не удалось загрузкить пользовательские функции: " + Символы.ПС + Результат.errorDescription);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТекстМакета(ИмяМакета)
	
	Макет = ПолучитьМакет(ИмяМакета);
	Возврат СтрЗаменить(Макет.ПолучитьТекст(), Символы.ПС, " ");	
	
КонецФункции

&НаСервере
Функция ЭтотОбъект()
	
	Возврат РеквизитФормыВЗначение("Объект");
	
КонецФункции

&НаСервере
Функция ПолучитьМакет(ИмяМакета)
	
	Возврат ЭтотОбъект().ПолучитьМакет(ИмяМакета);
	
КонецФункции



// UPD  End 24.07.2020
#КонецОбласти 