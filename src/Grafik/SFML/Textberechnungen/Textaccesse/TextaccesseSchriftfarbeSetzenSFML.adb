pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;
with StadtDatentypen;
with EinheitenDatentypen;
with ForschungKonstanten;
with ForschungenDatentypen;

with TexteinstellungenSFML;

package body TextaccesseSchriftfarbeSetzenSFML is

   procedure SchriftfarbeSetzen
   is begin
      
      MenüsEinfach;
      ZusatztextRassenmenü;
      ZusatztextKartengröße;
      Baumenü;
      Forschungsmenü;
      Sprachauswahl;
      Kartenformauswahl;
      StadtInformationen;
      EinheitenInformationen;
      KarteWichtiges;
      KarteAllgemeines;
      Karte;
      Zahleneingabe;
      EinheitStadtAuswahl;
      AnzeigeEingabe;
      Ladezeiten;
      
   end SchriftfarbeSetzen;
   
   
   
   procedure MenüsEinfach
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
      
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
   end MenüsEinfach;
      
      
   
   procedure ZusatztextRassenmenü
   is begin
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextRassenmenüSchleife;
      
   end ZusatztextRassenmenü;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
      
   
   
   procedure Baumenü
   is begin
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.ÜberschriftAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudetextAccess (0),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in StadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            
      end loop GebäudetextSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitentextAccess (0),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitentextSchleife;
      
   end Baumenü;
      
      
   
   procedure Forschungsmenü
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
                  
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ForschungenSchleife;
      
   end Forschungsmenü;
      
      
   
   procedure Sprachauswahl
   is begin
      
      ForschungenZusatztextSchleife:
      for ForschungZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungZusatztextSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop ForschungenZusatztextSchleife;
      
   end Sprachauswahl;
   
      
   
   procedure Kartenformauswahl
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'First + 1 .. TextaccessVariablen.KartenformauswahlAccessArray'Last - 1 loop
         
         case
           SchriftfarbeSchleifenwert
         is
            when 10 .. 30 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeMenschText);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         end case;
         
      end loop SchriftfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAccess,
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Karte;
   
   
   
   procedure Zahleneingabe
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Zahleneingabe;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (TextaccessVariablen.JaNeinAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'First + 1 .. TextaccessVariablen.JaNeinAccessArray'Last loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.LadezeitenAccess (TextaccessVariablen.LadezeitenAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'First + 1 .. TextaccessVariablen.LadezeitenAccessArray'Last loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccessArray'First + 1 .. TextaccessVariablen.KIZeitenAccessArray'Last loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop KIZeitenSchleife;
      
      
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
         
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccessArray'Last),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
      
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccessArray'First),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
         
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccessArray'Last),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
      
   end Ladezeiten;

end TextaccesseSchriftfarbeSetzenSFML;
