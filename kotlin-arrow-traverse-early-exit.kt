fun main(){
    fun parseIntEither(s: String): Either<NumberFormatException, Int> =
        if (s.matches(Regex("-?[0-9]+"))) Either.Right(s.toInt())
        else Either.Left(NumberFormatException("$s is not a valid integer."))

    val list = listOf("1", "2", "3").k().traverse(Either.applicative(), ::parseIntEither)
    val failFastList = listOf("1", "abc", "3", "4s").k().traverse(Either.applicative(), ::parseIntEither)
    println("${list}") //  Right([1, 2, 3])
    println("${failFastList}") //  Left(java.lang.NumberFormatException: abc is not a valid integer.)
}