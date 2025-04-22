with SystemDatentypen;
with TextnummernKonstanten;
with ZahlenDatentypen;

package SystemKonstanten is
   pragma Pure;
      
   LeerMeldung : constant TextnummernKonstanten.Spielmeldungen := TextnummernKonstanten.Spielmeldungen'First;
   
   NichtsVorhanden : constant SystemDatentypen.Feldelementezahl := 0;
   ZusatzgrundVorhanden : constant SystemDatentypen.Feldelementezahl := 1;
   FeldeffekteVorhanden : constant SystemDatentypen.Feldelementezahl := 2;
   FlussVorhanden : constant SystemDatentypen.Feldelementezahl := 4;
   RessourcenVorhanden : constant SystemDatentypen.Feldelementezahl := 8;
   WegVorhanden : constant SystemDatentypen.Feldelementezahl := 16;
   VerbesserungVorhanden : constant SystemDatentypen.Feldelementezahl := 32;
   EinheitVorhanden : constant SystemDatentypen.Feldelementezahl := 64;
   StadtVorhanden : constant SystemDatentypen.Feldelementezahl := 128;
   
   MaximaleEingabe : constant ZahlenDatentypen.EigenesPositive := 999_999_999;
   
   MinimaleEingabe : constant ZahlenDatentypen.EigenerInteger := -999_999_999;
   
   Abwählen : constant Natural := 0;
   
   AbwählenNegativ : constant Integer := -1;

end SystemKonstanten;
