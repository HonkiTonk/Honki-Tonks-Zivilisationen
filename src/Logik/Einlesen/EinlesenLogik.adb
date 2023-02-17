with TextKonstanten;

with EinlesenSpracheLogik;
with EinlesenTextLogik;
with EinlesenTastaturLogik;
with EinlesenDatenbankenLogik;
with SchreibenEinstellungenLogik;
with SprachauswahlLogik;
with EinlesenTexturenLogik;
with Fehlermeldungssystem;
with EinlesenMusikLogik;
with EinlesenSoundsLogik;
with EinlesenSpeziestexteLogik;
with SchreibeOptionen;
with LeseOptionen;

package body EinlesenLogik is

   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenDatenbankenLogik.AlleDatenbanken;
      EinlesenTastaturLogik.Tastaturbelegung;
      EinlesenTexturenLogik.EinlesenTexturen;
      EinlesenMusikLogik.EinlesenMusik;
      EinlesenSoundsLogik.EinlesenSounds;
      
   end EinlesenOhneAnzeige;
   
   
   
   procedure EinlesenMitAnzeige
   is begin
      
      if
        LeseOptionen.Sprache = TextKonstanten.LeerUnboundedString
      then
         case
           EinlesenSpracheLogik.EinlesenSprache
         is
            when True =>
               SpracheAuswählenSchleife:
               loop
                  
                  GewählteSprache := SprachauswahlLogik.AuswahlSprache;
                  
                  if
                    GewählteSprache = TextKonstanten.LeerUnboundedString
                  then
                     null;
                     
                  else
                     exit SpracheAuswählenSchleife;
                  end if;
                  
               end loop SpracheAuswählenSchleife;
                  
               SchreibeOptionen.Sprache (SpracheExtern => GewählteSprache);
               SchreibenEinstellungenLogik.Nutzereinstellungen;
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenLogik.EinlesenMitAnzeige: Sprachen nicht gefunden");
         end case;
               
      else
         null;
      end if;
      
      EinlesenTextLogik.EinlesenDateien;
      EinlesenSpeziestexteLogik.SpeziestexteEinlesen;
      
   end EinlesenMitAnzeige;

end EinlesenLogik;
