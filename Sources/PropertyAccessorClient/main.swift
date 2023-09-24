import PropertyAccessor

struct Foo {
    var value: Int
}

struct Bar {
    
    private var foo: Foo
    
    @Accessor(to: \Self.foo.value)
    var fooValue: Int
    
    @Accessor(to: \Self.foo.value)
    var fooValue2: Int, fooValue3: Int
    
    @Accessor(to: \Self.foo.value)
    let fooValueLet: Int
    
    init(foo: Foo) {
        self.foo = foo
    }
}

var bar = Bar(foo: Foo(value: 10))
print(bar.fooValue)

bar.fooValue = 50
print(bar.fooValue)

bar.fooValue2 = 100
print(bar.fooValue)

bar.fooValue3 = 200
print(bar.fooValue)

print(bar.fooValueLet)
