package docspell.query.internal

import cats.parse.{Parser => P}

import docspell.query.ItemQuery
import docspell.query.ItemQuery._

object ExprParser {

  def and(inner: P[Expr]): P[Expr.AndExpr] =
    inner
      .repSep(BasicParser.ws1)
      .between(BasicParser.parenAnd, BasicParser.parenClose)
      .map(Expr.AndExpr.apply)

  def or(inner: P[Expr]): P[Expr.OrExpr] =
    inner
      .repSep(BasicParser.ws1)
      .between(BasicParser.parenOr, BasicParser.parenClose)
      .map(Expr.OrExpr.apply)

  def not(inner: P[Expr]): P[Expr] =
    (P.char('!') *> inner).map(_.negate)

  val exprParser: P[Expr] =
    P.recursive[Expr] { recurse =>
      val andP = and(recurse)
      val orP  = or(recurse)
      val notP = not(recurse)
      P.oneOf(SimpleExprParser.simpleExpr :: andP :: orP :: notP :: Nil)
    }

  def parseQuery(input: String): Either[P.Error, ItemQuery] = {
    val p = BasicParser.ws0 *> exprParser <* (BasicParser.ws0 ~ P.end)
    p.parseAll(input).map(expr => ItemQuery(expr, Some(input)))
  }
}
