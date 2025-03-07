with TextKonstanten;
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
        LeseOptionen.Sprache /= TextKonstanten.LeerUnboundedString
      then
         null;
         
      elsif
        Systemsprache = True
      then
         SchreibeOptionen.Sprache (SpracheExtern => GewählteSprache);
         SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => True);
         SchreibenEinstellungenLogik.Nutzereinstellungen;
         
      else
         case
           EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.Sprachen)
         is
            when True =>
               SpracheAuswählenSchleife:
               loop
                  
                  GewählteSprache := SetauswahlLogik.Setauswahl (SpracheExtern => True);
                  
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenLogik.EinlesenMitAnzeige: Sprachen nicht gefunden");
               return;
         end case;
      end if;
      
      EinlesenTextLogik.EinlesenDateien (EinsprachigExtern => True);
      
   end EinlesenMitAnzeige;
   
   
   
   -- Hier noch eine Prüfung einbauen ob der Sprachordner überhaupt vorhanden ist? äöü
   -- Oder sollte das bei den Standardsprachen selbstverständlich sein? äöü
   -- Hier auch die Sprache zurückgeben. äöü
   function Systemsprache
     return Boolean
   is begin
      
      LokaleSprache := Ada.Locales.Language;
      
      if
        LokaleSprache = Ada.Locales.Language_Unknown
      then
         return False;
         
      else
         null;
      end if;
      
      SprachenSchleife:
      for SprachenSchleifenwert in StandardsprachenArray'Range loop
         
         if
           LokaleSprache = Standardsprachen (SprachenSchleifenwert).ISONummer
         then
            GewählteSprache := Standardsprachen (SprachenSchleifenwert).Sprache;
            return True;
            
         else
            null;
         end if;
         
      end loop SprachenSchleife;
            
      return False;
      
   end Systemsprache;

end EinlesenLogik;
