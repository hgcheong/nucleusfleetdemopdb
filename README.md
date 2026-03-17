# webuitest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Steps to Add A new Form
1)Check the url
2)Add to Constructor the Id field


flutter build web --base-href "/nucleusfleet/"

if intl_util not generating run this command dart run intl_utils:generate


flutter build web --release --base-href "/nucleusfleet/" --pwa-strategy=none

inorder to successfully force client to update we need to increment the below
  <script src="flutter_bootstrap.js?v=10002" async></script>

  <script>
  //   window.addEventListener('load', function(ev) {
  //    {{flutter_js}}
  //    {{flutter_build_config}}
   
  //    _flutter.loader.load({
  
  //      onEntrypointLoaded: function(engineInitializer) {
  //        engineInitializer.initializeEngine().then(function(appRunner) {
  //          if(document.getElementById('splash'))
  //            document.getElementById('splash').remove();
  //          appRunner.runApp();
  //        });
  //      }
  //    });
  //  });
 </script>


 dart compile js -v -h
...
  -O<0,1,2,3,4>
    Controls optimizations that can help reduce code-size and improve
    performance of the generated code for deployment.

    -O0
       Disables all optimizations. Equivalent to calling dart2js with these
       extra flags:
        --disable-inlining
        --disable-type-inference
        --disable-rti-optimizations


       Some optimizations cannot be dissabled at this time, as we add the option
       to disable them, they will be added here as well.

    -O1
       Enables default optimizations. Equivalent to calling dart2js with no
       extra flags.

    -O2
       Enables optimizations that respect the language semantics and are safe
       for all programs. It however changes the string representation of types,
       which will no longer be consistent with the Dart VM or DDC.

       Equivalent to calling dart2js with these extra flags:
        --minify
        --lax-runtime-type-to-string
        --omit-late-names

    -O3
       Enables optimizations that respect the language semantics only on
       programs that do not ever throw any subtype of `Error`.  These
       optimizations improve the generated code, but they may cause programs to
       behave unexpectedly if this assumption is not met.  To use this
       option, we recommend that you properly test your application first
       without it, and ensure that no subtype of `Error` (such as `TypeError`)
       is ever thrown.

       Equivalent to calling dart2js with these extra flags:
         -O2
         --omit-implicit-checks

    -O4
       Enables more aggressive optimizations than -O3, but with the same
       assumptions. These optimizations are on a separate group because they
       are more susceptible to variations in input data. To use this option we
       recommend to pay special attention to test edge cases in user input.

       Equivalent to calling dart2js with these extra flags:
         -O3
         --trust-primitives

    While some of the individual optimizations and flags may change with time,
    we intend to keep the -O* flags stable. New safe optimizations may be added
    on any level, and optimizations that only work on some programs may move up
    from one level to the next (for instance, once alternative safe
    c


    flutter build web --base-href "/nucleusfleet/" --profile --dart-define=Dart2jsOptimization=O2

    1st Import to UserWebModuleTemplateImport
    2nd Run using console program to extract from excel file
    3 exec ApiSignInTmplModuleSave for user Group


    To do
    1)Remove Acct Manager from Cust Enroll and Cust