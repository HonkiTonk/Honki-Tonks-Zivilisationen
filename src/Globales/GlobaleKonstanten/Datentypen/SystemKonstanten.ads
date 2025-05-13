with SystemDatentypen;
with TextnummernKonstanten;
with ZahlenDatentypen;

package SystemKonstanten is
   pragma Pure;
      
   LeerMeldung : constant TextnummernKonstanten.Spielmeldungen := TextnummernKonstanten.Spielmeldungen'First;
   
   LeerEinByte : constant SystemDatentypen.EinByte := 0;
   LeerZweiByte : constant SystemDatentypen.ZweiByte := 0;
   LeerVierByte : constant SystemDatentypen.VierByte := 0;
   
   MaximaleEingabe : constant ZahlenDatentypen.EigenesPositive := 999_999_999;
   
   MinimaleEingabe : constant ZahlenDatentypen.EigenerInteger := -999_999_999;
   
   Abwählen : constant Natural := 0;
   
   AbwählenNegativ : constant Integer := -1;

end SystemKonstanten;
