import PropertyAccessor

struct Foo {
    var value: Int
}

struct Bar {
    
    private var foo: Foo
    
    @Accessor(to: \Self.foo.value)
    var fooValue: Int
    
    init(foo: Foo) {
        self.foo = foo
    }
}

var bar = Bar(foo: Foo(value: 10))
print(bar.fooValue)
bar.fooValue = 50
print(bar.fooValue)
