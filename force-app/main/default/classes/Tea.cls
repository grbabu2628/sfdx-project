public class Tea {
    public static void orderTea(){
        /*Set<String> teaTypes = New Set<String>();
        teaTypes.add('Black');
        teaTypes.add('White');
        teaTypes.add('Green');
        System.debug('Tea Types>>>' + teaTypes);*/
        /*Set<String> teaTypes = New Set<String>{'Black', 'White', 'Green'};
        system.debug('Tea Types :' + teaTypes);
        teatypes.add('Black');
        teaTypes.add('White');
        teaTypes.add('Yellow');
        System.debug('Tea Types 1 :' + teaTypes);*/
        Map<String, String> teaTypes = New Map<String, String>();
        teaTypes.put('Black', 'Earthy');
        teaTypes.put('White', 'Sweet');
        teaTypes.put('Herbal', 'Sweet');
        system.debug(teaTypes);
        
    }
}