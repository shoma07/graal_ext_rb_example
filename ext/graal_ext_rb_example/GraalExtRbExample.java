// https://www.graalvm.org/latest/reference-manual/native-image/guides/build-native-shared-library/
import org.graalvm.nativeimage.IsolateThread;
import org.graalvm.nativeimage.c.function.CEntryPoint;

public class GraalExtRbExample {
    @CEntryPoint(name = "add")
    static int add(IsolateThread thread, int a, int b) {
        return a + b;
    }
}
