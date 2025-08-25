with SystemDatentypenHTSEB;

package SystemKonstantenHTSEB is
   pragma Pure;
   
   Nullwert : constant SystemDatentypenHTSEB.EigenesNatural := SystemDatentypenHTSEB.EigenesNatural'First;
   Einswert : constant SystemDatentypenHTSEB.EigenesPositive := SystemDatentypenHTSEB.EigenesPositive'First;
   
   KommazahlNullwert : constant Float := 0.00;
   KommazahlEinswert : constant Float := 1.00;
   
   LeerEinByte : constant SystemDatentypenHTSEB.EinByte := 0;
   LeerZweiByte : constant SystemDatentypenHTSEB.ZweiByte := 0;
   LeerVierByte : constant SystemDatentypenHTSEB.VierByte := 0;
   
   LeerEinByteVorzeichen : constant SystemDatentypenHTSEB.EinByteVorzeichen := 0;
   LeerZweiByteVorzeichen : constant SystemDatentypenHTSEB.ZweiByteVorzeichen := 0;
   LeerVierByteVorzeichen : constant SystemDatentypenHTSEB.VierByteVorzeichen := 0;

end SystemKonstantenHTSEB;
