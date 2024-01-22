include(RunCMake)

run_cmake(BadByproduct)
run_cmake(BadCommand)
run_cmake(BadTargetName)
run_cmake(ByproductsNoCommand)
run_cmake(CommandExpandsEmpty)
run_cmake(GeneratedProperty)
run_cmake(LiteralQuotes)
run_cmake(NoArguments)
run_cmake(UsesTerminalNoCommand)

function(run_TargetOrder)
  # Use a single build tree for a few tests without cleaning.
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/TargetOrder-build)
  set(RunCMake_TEST_NO_CLEAN 1)
  file(REMOVE_RECURSE "${RunCMake_TEST_BINARY_DIR}")
  file(MAKE_DIRECTORY "${RunCMake_TEST_BINARY_DIR}")
  run_cmake(TargetOrder)
  if(RunCMake_GENERATOR STREQUAL "Ninja")
    set(build_flags -j 1 -v)
  endif()
  run_cmake_command(TargetOrder-build ${CMAKE_COMMAND} --build . -- ${build_flags})
endfunction()
run_TargetOrder()

if(NOT RunCMake_GENERATOR STREQUAL "Xcode")
  block()
    run_cmake(CommentGenex)
    set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/CommentGenex-build)
    set(RunCMake_TEST_NO_CLEAN 1)
    run_cmake_command(CommentGenex-build ${CMAKE_COMMAND} --build .)
  endblock()
endif()
