/* 2 Byte Pointers */
#if defined(__IP16L32__) || defined(__IP16L32) || defined(IP16L32)
#	define DATA_MODEL_IP16L32
#	define DATA_MODEL_NEAR
#endif

/* 4 Byte Pointers */
#if defined(__I16LP32__) || defined(__I16LP32) || defined(I16LP32)
#	define DATA_MODEL_I16LP32
#	define DATA_MODEL_FAR
#endif

#if defined(__LP32__) || defined(__LP32) || defined(LP32)
#	define DATA_MODEL_LP32
#	define DATA_MODEL_FAR
#endif

#if defined(__ILP32__) || defined(__ILP32) || defined(ILP32)
#	define DATA_MODEL_ILP32
#	define DATA_MODEL_FAR
#endif

/* 8 Byte Pointers */
#if defined(__LP64__) || defined(__LP64) || defined(LP64)
#	define DATA_MODEL_LP64
#	define DATA_MODEL_FAR
#endif

#if defined(__LLP64__) || defined(__LLP64) || defined(LLP64)
#	define DATA_MODEL_LLP64
#	define DATA_MODEL_FAR
#endif

#if defined(__ILP64__) || defined(__ILP64) || defined(ILP64)
#	define DATA_MODEL_ILP64
#	define DATA_MODEL_FAR
#endif

#if defined(__SILP64__) || defined(__SILP64) || defined(SILP64)
#	define DATA_MODEL_SILP64
#	define DATA_MODEL_FAR
#endif

#if defined(__CSILP64__) || defined(__CSILP64) || defined(CSILP64)
#	define DATA_MODEL_CSILP64
#	define DATA_MODEL_FAR
#endif