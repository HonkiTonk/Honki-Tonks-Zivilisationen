pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with TextaccessVariablen;
with EinheitStadtDatentypen;
with GlobaleTexte;
with TextKonstanten;
with ForschungKonstanten;
with ForschungenDatentypen;

with GrafikEinstellungenSFML;

package body TextaccesseStandardSetzenSFML is
   
   procedure AllesAufStandard
   is begin
      
      SchriftartSetzen;
      SchriftgrößeSetzen;
      SchriftfarbeSetzen;
      TextSetzen;
      
   end AllesAufStandard;
   
   

   procedure SchriftartSetzen
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextRassenmenüSchleife;
      
      
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextKartengrößeSchleife;
      
      
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.BaumenüÜberschriftAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop GebäudetextSchleife;
      
      GebäudezusatztextSchleife:
      for GebäudezusatztextSchleifenwert in TextaccessVariablen.GebäudezusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudezusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop GebäudezusatztextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop EinheitentextSchleife;
      
      EinheitenzusatztextSchleife:
      for EinheitenzusatztextSchleifenwert in TextaccessVariablen.EinheitenzusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitenzusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop EinheitenzusatztextSchleife;
      
      
      
      ForschungenSchleife:
      for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop ForschungenSchleife;
      
      ForschungenZusatztextSchleife:
      for ForschungZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungZusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ForschungenZusatztextSchleife;
      
   end SchriftartSetzen;
   
   
   
   procedure SchriftgrößeSetzen
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                               size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop ZusatztextRassenmenüSchleife;
      
      
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop ZusatztextKartengrößeSchleife;
      
      
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
            
      end loop GebäudetextSchleife;
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop EinheitentextSchleife;
      
   end SchriftgrößeSetzen;
   
   
   
   procedure SchriftfarbeSetzen
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
      
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextRassenmenüSchleife;
      
      
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextKartengrößeSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.BaumenüÜberschriftAccess,
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudetextAccess (0),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            
      end loop GebäudetextSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitentextAccess (0),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitentextSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
                  
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ForschungenSchleife;
      
      ForschungenZusatztextSchleife:
      for ForschungZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungZusatztextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ForschungenZusatztextSchleife;
      
   end SchriftfarbeSetzen;
   
   
   
   procedure TextSetzen
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.BaumenüÜberschriftAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageBauprojekt)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (0),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGebäude)));
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert) - 1)));
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Gebäude (2 * Positive (GebäudetextSchleifenwert))));
            
      end loop GebäudetextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (0),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugEinheiten)));
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (EinheitentextSchleifenwert) - 1)));
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (EinheitentextSchleifenwert))));
         
      end loop EinheitentextSchleife;
      
      
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextKonstanten.FrageForschungsprojekt)));
      
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (ForschungSchleifenwert) - 1)));
         
      end loop ForschungenSchleife;
      
      ForschungenZusatztextSchleife:
      for ForschungZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungZusatztextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Forschungen (2 * Positive (ForschungZusatztextSchleifenwert))));
         
      end loop ForschungenZusatztextSchleife;
      
   end TextSetzen;

end TextaccesseStandardSetzenSFML;
