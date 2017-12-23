SELECT * FROM [Orders]

--За да изтрием това, което е вързано с табл OrdersParts
  DELETE FROM Orders
  WHERE OrderId=19

 --1.Отиваме да видим с какво е вързано в тази табл
 SELECT * FROM OrderParts
 WHERE OrderId = 19

--2.Изтримаве редовете дето го има нашето Id
 DELETE FROM OrderParts
 WHERE OrderId = 19


 --Само това пускаш:
  DELETE FROM OrderParts
 WHERE OrderId = 19

   DELETE FROM Orders
  WHERE OrderId=19