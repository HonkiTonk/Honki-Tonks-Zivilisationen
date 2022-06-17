pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with ForschungKonstanten;

with GrafikEinstellungenSFML;

package body TextaccesseSchriftgroesseSetzenSFML is

   procedure SchriftgrößeSetzen
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
      
   end SchriftgrößeSetzen;
   
   
   
   procedure MenüsEinfach
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                               size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
   end MenüsEinfach;
      
      
   
   procedure ZusatztextRassenmenü
   is begin
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop ZusatztextRassenmenüSchleife;
      
   end ZusatztextRassenmenü;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
      
      
   
   procedure Baumenü
   is begin
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in StadtDatentypen.GebäudeID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            
      end loop GebäudetextSchleife;
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
            
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop EinheitentextSchleife;
      
   end Baumenü;
      
      
   
   procedure Forschungsmenü
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüAccess (ForschungKonstanten.LeerForschung),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop SchriftgrößeSchleife;
      
      ZusatztextSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ZusatztextSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop ZusatztextSchleife;
      
   end Forschungsmenü;
      
      
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SprachauswahlAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'First + 1 .. TextaccessVariablen.KartenformauswahlAccessArray'Last - 1 loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop SchriftgrößeSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeKlein);
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccessArray'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccessArray'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAccess,
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Karte;
   
   
   
   procedure Zahleneingabe
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Zahleneingabe;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.JaNeinAccess (TextaccessVariablen.JaNeinAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'First + 1 .. TextaccessVariablen.JaNeinAccessArray'Last loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.LadezeitenAccess (TextaccessVariablen.LadezeitenAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'First + 1 .. TextaccessVariablen.LadezeitenAccessArray'Last loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KIZeitenAccess (TextaccessVariablen.KIZeitenAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccessArray'First + 1 .. TextaccessVariablen.KIZeitenAccessArray'Last loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                            size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
         
      end loop KIZeitenSchleife;
               
      
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
         
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.RundenendeAccess (TextaccessVariablen.RundenendeAccessArray'Last),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
      
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccessArray'First),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
         
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.SpeichernLadenAccess (TextaccessVariablen.SpeichernLadenAccessArray'Last),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Ladezeiten;

end TextaccesseSchriftgroesseSetzenSFML;
