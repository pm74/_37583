﻿// Процедура добавляет команду обработки в таблицу
//
Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

// Функция предоставляет сведения об обработке для
// подключения к кофигурации
//
Функция СведенияОВнешнейОбработке() Экспорт
		
	РегистрационныеДанные = Новый Структура;
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	
	ДобавитьКоманду(Команды, "Консоль кода", "КонсольКода", "ОткрытиеФормы");	
	
	//Инициализация сведений об обработке 
	РегистрационныеДанные.Вставить("Вид"			, "ДополнительнаяОбработка");
	РегистрационныеДанные.Вставить("Назначение"		, Неопределено);
	РегистрационныеДанные.Вставить("Наименование"	, "Консоль кода");
	РегистрационныеДанные.Вставить("Версия"			, "20200722ы");
	РегистрационныеДанные.Вставить("БезопасныйРежим", Ложь);
	РегистрационныеДанные.Вставить("Информация"		, "Консоль кода для управляемых форм");
	РегистрационныеДанные.Вставить("Команды"		, Команды);
	
	Возврат РегистрационныеДанные;
	
КонецФункции