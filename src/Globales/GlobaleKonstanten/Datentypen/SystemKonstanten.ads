with SystemDatentypenHTSEB;

with TextnummernKonstanten;
with ZahlenDatentypen;

package SystemKonstanten is
   pragma Pure;
   use type SystemDatentypenHTSEB.EinByteVorzeichen;
      
   LeerMeldung : constant TextnummernKonstanten.Spielmeldungen := TextnummernKonstanten.Spielmeldungen'First;
      
   -- Eventuell mal eigene Konstanten für das Speichersystem anlegen. äöü
   AllesSichtbar : constant SystemDatentypenHTSEB.EinByteVorzeichen := -1;
   AllesUnsichtbar : constant SystemDatentypenHTSEB.EinByteVorzeichen := -2;
   
   MaximaleEingabe : constant ZahlenDatentypen.EigenesPositive := 999_999_999;
   
   MinimaleEingabe : constant ZahlenDatentypen.EigenerInteger := -999_999_999;
   
   Abwählen : constant Natural := 0;
   
   AbwählenNegativ : constant Integer := -1;

end SystemKonstanten;
