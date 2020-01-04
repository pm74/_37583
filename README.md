# _37583 (алгоритмы)

Расширение для 1с (8.3.11 + , БСП 2+) 

Основные возможности:

* выплнение произвольного кода на клиенте и сервере
* взаимные вызовы алгоритмов с передачей параметров
* сохраняемые параметры алгоритма (параметры по умолчанию)
* команды объектов
* регламентные задания
* настраиваемые веб сервисы

```1c-enterprise
// http://192.168.1.112/evroprivod/hs/alg/test
ЗаписьJSON = Новый ЗаписьJSON; 
ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет); 
ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON); 

ЗаписатьJSON(ЗаписьJSON,_37583_АлгоритмыСервер.ТзВМассивСтруктур(@Таблица));
// [{"число":1,"Строка":"первая строка"},{"число":2,"Строка":"вторая строка"}]
// или
ЗаписатьJSON(ЗаписьJSON,_37583_АлгоритмыСервер.ТзВСтруктуруМассивов(@Таблица)); 
//{"число":[1,2],"Строка":["первая строка","вторая строка"]}

СтрокаJSON = ЗаписьJSON.Закрыть(); 
Возврат СтрокаJSON; 

//  http://192.168.1.112/evroprivod/hs/alg/test?table_num=2
Если @table_num = "2" Тогда 
	тз = @Таблица2; 
Иначе 
	тз = @Таблица; 
КонецЕсли; 
ЗаписьJSON = Новый ЗаписьJSON; 
ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет); 
ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON); 
ЗаписатьJSON(ЗаписьJSON,_37583_АлгоритмыСервер.ТзВМассивСтруктур(тз)); 
//[{"Дата":"2020-01-01T00:00:00","Булево":true},{"Дата":"2020-01-02T00:00:00","Булево":false}]
СтрокаJSON = ЗаписьJSON.Закрыть(); 
Возврат СтрокаJSON; 
```

```python
In[1]: 
import requests , json  
response = requests.get('http://hostname/basename/hs/alg/test', auth=(username, password))
text_json = json.loads(response.text.replace('\ufeff',''))
print(text_json)
for i in text_json:
 print(i['Строка'])
Out[1]:
[{'число': 1, 'Строка': 'первая строка'}, {'число': 2, 'Строка': 'вторая строка'}]
первая строка
вторая строка


```


* лог ошибок в  журнале регистрации
* дополнительные роли - использование и редактирование алгоритмов
* экспорт/импорт .xml
