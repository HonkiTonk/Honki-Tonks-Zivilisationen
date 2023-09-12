with TextKonstanten;

with SchreibeGrafiktask;
with SchreibeOptionen;
with LeseOptionen;

with EinlesenSpracheLogik;
with EinlesenTextLogik;
with EinlesenDatenbankenLogik;
with SchreibenEinstellungenLogik;
with SprachauswahlLogik;
with EinlesenTexturenLogik;
with Fehlermeldungssystem;
with EinlesenMusikLogik;
with EinlesenSoundsLogik;

package body EinlesenLogik is

   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenDatenbankenLogik.AlleDatenbanken;
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
               SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => True);
               SchreibenEinstellungenLogik.Nutzereinstellungen;
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenLogik.EinlesenMitAnzeige: Sprachen nicht gefunden");
         end case;
               
      else
         null;
      end if;
      
      EinlesenTextLogik.EinlesenDateien (EinsprachigExtern => True);
      
   end EinlesenMitAnzeige;

end EinlesenLogik;
