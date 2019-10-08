if Category.count == 0
  Category.create([
    {name: '読んでる'},
    {name: '読んだ'},
    {name: '読みたい'}
  ])
end