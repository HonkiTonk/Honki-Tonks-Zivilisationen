pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;

with TexteinstellungenSFML;

package body TextaccesseSchriftgroesseSetzenSFML is

   procedure SchriftgrößeSetzen
   is begin
      
      Allgemeines;
      Menüs;
      Rassen;
      ZusatztextKartengröße;
      Sprachauswahl;
      Kartenformauswahl;
      StadtInformationen;
      EinheitenInformationen;
      KarteWichtiges;
      KarteAllgemeines;
      Karte;
      EinheitStadtAuswahl;
      AnzeigeEingabe;
      Ladezeiten;
      
   end SchriftgrößeSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ÜberschriftAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.VersionsnummerAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZeilenumbruchAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeKlein);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TextAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                               size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungSFMLAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SteuerungSFMLAccess (SteuerungSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop SteuerungSchleife;
      
   end Menüs;
      
      
   
   procedure Rassen
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in TextaccessVariablen.RassennamenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RassennamenAccess (RasseSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RassenbeschreibungAccess (RasseSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
            when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                                  size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
               
            when others =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                                  size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudezusatztextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                                  size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            end case;
         
         end loop GebäudetextSchleife;


      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                                  size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
               
            when others =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                                  size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenzusatztextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                                  size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungstextSchleife:
         for ForschungstextSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüAccess (RasseSchleifenwert, ForschungstextSchleifenwert),
                                               size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
               
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseSchleifenwert, ForschungstextSchleifenwert),
                                               size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
         end loop ForschungstextSchleife;
         
      end loop RassenSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Rassen;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
            
      
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SprachauswahlAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'First),
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'First + 1 .. TextaccessVariablen.KartenformauswahlAccess'Last - 1 loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (SchriftgrößeSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop SchriftgrößeSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'Last),
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeKlein);
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                            size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop KIZeitenSchleife;
               
            
         
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.RundenendeAccess (1),
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
      
               
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.SpeichernLadenAccess (1),
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Ladezeiten;

end TextaccesseSchriftgroesseSetzenSFML;
