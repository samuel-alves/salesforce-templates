OrderDeliveryMethod method = new OrderDeliveryMethod();
method.Name = 'Test';
insert method;

OrderDeliveryGroup orderDeliveryGroup = new OrderDeliveryGroup(
    DesiredDeliveryDate=Date.today(),
    OrderDeliveryMethodId = 'xxxxxxxxxxxx001xxx',
    DeliverToName = 'Test User',
    OrderId = 'xxxxxxxxxxxx001xxx');
insert orderDeliveryGroup;

OrderItem item = new OrderItem(Id='xxxxxxxxxxxx001xxx', OrderDeliveryGroupId= orderDeliveryGroup.Id);
update item;

// encomenda tem de estar ativa para ser criada um summary
Order ord = new Order(Id = '', Status= 'Activated');
update ord;

ConnectApi.OrderSummaryInputRepresentation orderRep = new ConnectApi.OrderSummaryInputRepresentation();
orderRep.Name = '00032545'; // nome da encomenda, alterar
orderRep.orderId = 'xxxxxxxxxxxx001xxx'; // id da order original
orderRep.orderLifeCycleType = 'UNMANAGED'; // se for managed dá erro com ammounts nos line items
orderRep.status = 'Draft';
ConnectApi.OrderSummaryOutputRepresentation osor = ConnectApi.OrderSummaryCreation.createOrderSummary(orderRep);

// Para aparecer na lista de encomendas, precisa de ter orderedDate e a store
List<OrderSummary> sums = [Select Id, OrderedDate, SalesStoreId FROM OrderSummary WHERE Id = 'xxxxxxxxxxxx001xxx'];

for (OrderSummary sum : sums) {
    sum.OrderedDate= Datetime.now();
    sum.SalesStoreId='xxxxxxxxxxxx001xxx'; // TintexStore
}

update sums;