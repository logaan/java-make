# Find all the java files.
JAVA_FILES = $(shell find src -name "*.java")

# Once we know the java file paths we can calculate what the class paths should
# be. We could just do a find name for class files but that would mean that any
# new file that has not yet been compiled wouldn't trigger a build.
CLASS_FILES = $(subst src,build, \
	      $(addsuffix .class, \
	      $(basename \
	      $(JAVA_FILES))))

# To build everything we need to have built all the class files.
all: $(CLASS_FILES)

clean:
	rm -rf build

# This target says that any class file depends on a java file of the same name
# and path. The dependency file will be compiled.
build/%.class : src/%.java
	mkdir -p $(dir $@)
	javac -d $(dir $@) $<
