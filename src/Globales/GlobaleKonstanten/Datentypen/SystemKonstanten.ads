with SystemDatentypen;
with TextnummernKonstanten;
with ZahlenDatentypen;

package SystemKonstanten is
   pragma Pure;
      
   LeerMeldung : constant TextnummernKonstanten.Spielmeldungen := TextnummernKonstanten.Spielmeldungen'First;
   
   NichtsVorhanden : constant SystemDatentypen.EinByte := 0;
   ZusatzgrundVorhanden : constant SystemDatentypen.EinByte := 1;
   FeldeffekteVorhanden : constant SystemDatentypen.EinByte := 2;
   FlussVorhanden : constant SystemDatentypen.EinByte := 4;
   RessourcenVorhanden : constant SystemDatentypen.EinByte := 8;
   WegVorhanden : constant SystemDatentypen.EinByte := 16;
   VerbesserungVorhanden : constant SystemDatentypen.EinByte := 32;
   EinheitVorhanden : constant SystemDatentypen.EinByte := 64;
   StadtVorhanden : constant SystemDatentypen.EinByte := 128;
   
   MaximaleEingabe : constant ZahlenDatentypen.EigenesPositive := 999_999_999;
   
   MinimaleEingabe : constant ZahlenDatentypen.EigenerInteger := -999_999_999;
   
   Abwählen : constant Natural := 0;
   
   AbwählenNegativ : constant Integer := -1;

end SystemKonstanten;
