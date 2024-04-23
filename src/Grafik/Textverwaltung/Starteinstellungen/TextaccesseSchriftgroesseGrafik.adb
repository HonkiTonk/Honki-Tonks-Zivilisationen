with Sf.Graphics.Text;

with TextaccessVariablen;
with TextDatentypen;

package body TextaccesseSchriftgroesseGrafik is
   
   procedure SchriftgrößeSetzen
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32)
   is begin
      
      Texthöhen (ÜberschriftExtern => ÜberschriftExtern,
                  StandardExtern    => StandardExtern,
                  KleinExtern       => KleinExtern);
      
      Allgemeines (ÜberschriftExtern => ÜberschriftExtern,
                   StandardExtern    => StandardExtern,
                   KleinExtern       => KleinExtern);
      
      Menüs (StandardExtern => StandardExtern);
      
      Spezies (ÜberschriftExtern => StandardExtern,
               StandardExtern    => StandardExtern);
      
      ZusatztextKartengröße (StandardExtern => StandardExtern);
      
      Sprachauswahl (StandardExtern => StandardExtern);
      
      Kartenformauswahl (ÜberschriftExtern => StandardExtern,
                         StandardExtern    => StandardExtern);
      
      StadtInformationen (StandardExtern => StandardExtern);
      
      EinheitenInformationen (StandardExtern => StandardExtern);
      
      KarteWichtiges (StandardExtern => StandardExtern);
      
      KarteAllgemeines (StandardExtern => StandardExtern);
      
      Karte (ÜberschriftExtern => ÜberschriftExtern);
      
      EinheitStadtAuswahl (StandardExtern => StandardExtern);
      
      AnzeigeEingabe (StandardExtern => StandardExtern);
      
      Ladezeiten (StandardExtern => StandardExtern);
      
      Befehle (StandardExtern => StandardExtern);
      
   end SchriftgrößeSetzen;
   
   
   
   procedure Texthöhen
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32)
   is begin
      
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöhenAccess (TextDatentypen.Überschrift_Enum),
                                         size => ÜberschriftExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöhenAccess (TextDatentypen.Standard_Enum),
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöhenAccess (TextDatentypen.Klein_Enum),
                                         size => KleinExtern);
      
   end Texthöhen;
   
   
   
   procedure Allgemeines
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ÜberschriftAccess,
                                         size => ÜberschriftExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.VersionsnummerAccess,
                                         size => ÜberschriftExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZeilenumbruchAccess,
                                         size => KleinExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.Spielmeldung,
                                         size => StandardExtern);
                  
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.BildrateAccess,
                                         size => StandardExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.DiplomatieAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenseitenleisteAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EingabenanzeigeAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenbauinformationenAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudebauinformationenAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtkarteAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtumgebungAccess,
                                         size => StandardExtern);
      -- Später das Zeug überall sortieren. äöü
            
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                            size => StandardExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                            size => StandardExtern);
         
      end loop OutroSchleife;
      
      
      
      ZeugSchleife:
      for ZeugSchleifenwert in TextaccessVariablen.ZeugAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZeugAccess (ZeugSchleifenwert),
                                            size => StandardExtern);
         
      end loop ZeugSchleife;
      
      
      
      FragenSchleife:
      for FragenSchleifenwert in TextaccessVariablen.FragenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.FragenAccess (FragenSchleifenwert),
                                            size => StandardExtern);
         
      end loop FragenSchleife;
      
      
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in TextaccessVariablen.MeldungenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MeldungenAccess (MeldungenSchleifenwert),
                                            size => StandardExtern);
         
      end loop MeldungenSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (StandardExtern : in Sf.sfUint32)
   is begin
            
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                               size => StandardExtern);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                            size => StandardExtern);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                            size => StandardExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                            size => StandardExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32)
   is begin
            
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                            size => StandardExtern);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                            size => StandardExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => ÜberschriftExtern);
               
               when others =>
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => StandardExtern);
         
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => StandardExtern);
            end case;
         
         end loop GebäudetextSchleife;


      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => ÜberschriftExtern);
               
            when others =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => StandardExtern);
         
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => StandardExtern);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungstextSchleife:
         for ForschungstextSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungstextSchleifenwert),
                                               size => StandardExtern);
               
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungstextSchleifenwert),
                                               size => StandardExtern);
         
         end loop ForschungstextSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.AktuellesBauprojekt,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.AktuellesForschungsprojekt,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         size => StandardExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                            size => StandardExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
            
      
   
   procedure Sprachauswahl
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SprachauswahlAccess,
                                         size => StandardExtern);
            
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'First),
                                         size => ÜberschriftExtern);
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'First + 1 .. TextaccessVariablen.KartenformauswahlAccess'Last loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (SchriftgrößeSchleifenwert),
                                            size => StandardExtern);
         
      end loop SchriftgrößeSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                            size => StandardExtern);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                            size => StandardExtern);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                            size => StandardExtern);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                            size => StandardExtern);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (ÜberschriftExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAccess,
                                         size => ÜberschriftExtern);
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
     (StandardExtern : in Sf.sfUint32)
   is begin
            
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                            size => StandardExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            size => StandardExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (StandardExtern : in Sf.sfUint32)
   is begin
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                            size => StandardExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                            size => StandardExtern);
         
      end loop KIZeitenSchleife;
               
            
         
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RundenendeAccess (1),
                                         size => StandardExtern);
      
      
               
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeichernLadenAccess (1),
                                         size => StandardExtern);
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                            size => StandardExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftgroesseGrafik;
