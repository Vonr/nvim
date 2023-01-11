((((line_comment) @_comment
  (#match? @_comment "^///")) @rustdoc)
  (#offset! @rustdoc 0 0 3 0 0)) @markdown
