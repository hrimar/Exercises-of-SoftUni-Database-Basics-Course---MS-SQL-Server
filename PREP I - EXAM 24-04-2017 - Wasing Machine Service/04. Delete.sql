SELECT * FROM [Orders]

--�� �� ������� ����, ����� � ������� � ���� OrdersParts
  DELETE FROM Orders
  WHERE OrderId=19

 --1.������� �� ����� � ����� � ������� � ���� ����
 SELECT * FROM OrderParts
 WHERE OrderId = 19

--2.��������� �������� ���� �� ��� ������ Id
 DELETE FROM OrderParts
 WHERE OrderId = 19


 --���� ���� ������:
  DELETE FROM OrderParts
 WHERE OrderId = 19

   DELETE FROM Orders
  WHERE OrderId=19