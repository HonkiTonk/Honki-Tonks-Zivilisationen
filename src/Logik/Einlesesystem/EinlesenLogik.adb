with SystemspracheHTSEB;
with TextKonstantenHTSEB;

with VerzeichnisKonstanten;

with SchreibeGrafiktask;
with SchreibeOptionen;
with LeseOptionen;

with EinlesenTextLogik;
with EinlesenDatenbankenLogik;
with SchreibenEinstellungenLogik;
with SetauswahlLogik;
with EinlesenTexturenLogik;
with MeldungssystemHTSEB;
with EinlesenMusikLogik;
with EinlesenSoundsLogik;
with EinlesenSetsLogik;

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
        LeseOptionen.Sprache /= TextKonstantenHTSEB.LeerUnboundedString
      then
         EinlesenTextLogik.EinlesenDateien (EinsprachigExtern => True);
         return;
         
      else
         GewählteSprache := SystemspracheHTSEB.Systemsprache;
      end if;
         
      if
        GewählteSprache /= TextKonstantenHTSEB.LeerUnboundedString
      then
         null;
         
      else
         case
           EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.Sprachen)
         is
            when True =>
               SpracheAuswählenSchleife:
               loop
                  
                  GewählteSprache := SetauswahlLogik.Setauswahl (SpracheExtern => True);
                  
                  if
                    GewählteSprache = TextKonstantenHTSEB.LeerUnboundedString
                  then
                     null;
                     
                  else
                     exit SpracheAuswählenSchleife;
                  end if;
                  
               end loop SpracheAuswählenSchleife;
                  
            when False =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenLogik.EinlesenMitAnzeige: Sprachen nicht gefunden");
               return;
         end case;
      end if;
      
      SchreibeOptionen.Sprache (SpracheExtern => GewählteSprache);
      SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => True);
      SchreibenEinstellungenLogik.Nutzereinstellungen;
      EinlesenTextLogik.EinlesenDateien (EinsprachigExtern => True);
      
   end EinlesenMitAnzeige;

end EinlesenLogik;
