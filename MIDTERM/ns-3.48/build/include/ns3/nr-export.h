
#ifndef NR_EXPORT_H
#define NR_EXPORT_H

#ifdef NR_STATIC_DEFINE
#  define NR_EXPORT
#  define NR_NO_EXPORT
#else
#  ifndef NR_EXPORT
#    ifdef nr_EXPORTS
        /* We are building this library */
#      define NR_EXPORT __attribute__((visibility("default")))
#    else
        /* We are using this library */
#      define NR_EXPORT __attribute__((visibility("default")))
#    endif
#  endif

#  ifndef NR_NO_EXPORT
#    define NR_NO_EXPORT __attribute__((visibility("hidden")))
#  endif
#endif

#ifndef NR_DEPRECATED
#  define NR_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef NR_DEPRECATED_EXPORT
#  define NR_DEPRECATED_EXPORT NR_EXPORT NR_DEPRECATED
#endif

#ifndef NR_DEPRECATED_NO_EXPORT
#  define NR_DEPRECATED_NO_EXPORT NR_NO_EXPORT NR_DEPRECATED
#endif

/* NOLINTNEXTLINE(readability-avoid-unconditional-preprocessor-if) */
#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef NR_NO_DEPRECATED
#    define NR_NO_DEPRECATED
#  endif
#endif

// Undefine the *_EXPORT symbols for non-Windows based builds
#ifndef NS_MSVC
#undef NR_EXPORT
#define NR_EXPORT
#undef NR_NO_EXPORT
#define NR_NO_EXPORT
#endif
#endif /* NR_EXPORT_H */
