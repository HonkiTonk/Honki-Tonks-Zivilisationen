with SystemDatentypenHTSEB;

package SystemKonstantenHTSEB is
   pragma Pure;
   
   Nullwert : constant SystemDatentypenHTSEB.EigenesNatural := SystemDatentypenHTSEB.EigenesNatural'First;
   Einswert : constant SystemDatentypenHTSEB.EigenesPositive := SystemDatentypenHTSEB.EigenesPositive'First;
   
   KommazahlNullwert : constant Float := 0.00;
   KommazahlEinswert : constant Float := 1.00;

end SystemKonstantenHTSEB;
