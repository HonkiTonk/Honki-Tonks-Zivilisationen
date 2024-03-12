with SystemDatentypen;
with TextnummernKonstanten;
with ZahlenDatentypen;
with VerzeichnisKonstanten;

package SystemKonstanten is
   pragma Pure;
   
   MaximaleZeichenlängeDateisystem : constant Positive := 255;
   MaximaleSpielstandlängeWindows : constant Positive := MaximaleZeichenlängeDateisystem - VerzeichnisKonstanten.SpielstandStrich'Length - VerzeichnisKonstanten.SpielstandSpieler'Length;
   
   LeerMeldung : constant TextnummernKonstanten.Spielmeldungen := TextnummernKonstanten.Spielmeldungen'First;
   
   NichtsVorhanden : constant SystemDatentypen.FeldelementVorhanden := 0;
   ZusatzgrundVorhanden : constant SystemDatentypen.FeldelementVorhanden := 1;
   FeldeffekteVorhanden : constant SystemDatentypen.FeldelementVorhanden := 2;
   FlussVorhanden : constant SystemDatentypen.FeldelementVorhanden := 4;
   RessourcenVorhanden : constant SystemDatentypen.FeldelementVorhanden := 8;
   WegVorhanden : constant SystemDatentypen.FeldelementVorhanden := 16;
   VerbesserungVorhanden : constant SystemDatentypen.FeldelementVorhanden := 32;
   EinheitVorhanden : constant SystemDatentypen.FeldelementVorhanden := 64;
   StadtVorhanden : constant SystemDatentypen.FeldelementVorhanden := 128;
   
   MaximaleEingabe : constant ZahlenDatentypen.EigenesPositive := 999_999_999;
   
   MinimaleEingabe : constant ZahlenDatentypen.EigenerInteger := -999_999_999;
   
   Abwählen : constant Natural := 0;
   
   AbwählenNegativ : constant Integer := -1;

end SystemKonstanten;
