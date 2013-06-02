# Find all the java files.
java_files = $(shell find src -name "*.java")

# Once we know the java file paths we can calculate what the class paths should
# be. We could just do a find name for class files but that would mean that any
# new file that has not yet been compiled wouldn't trigger a build.
class_files = $(subst src,build, \
	      $(addsuffix .class, \
	      $(basename \
	      $(java_files))))

# To build everything we need to have built all the class files.
all: $(class_files)

.PHONY: clean

clean:
	@rm -rf build

# This target says that any class file depends on a java file of the same name
# and path. The dependency file will be compiled.
#
# @ before command supresses output
# $(@D) is the directory of the target (the class file).
# $< is the prerequisite (the java file).
build/%.class : src/%.java
	@mkdir -p $(@D)
	@javac -d $(@D) $<

