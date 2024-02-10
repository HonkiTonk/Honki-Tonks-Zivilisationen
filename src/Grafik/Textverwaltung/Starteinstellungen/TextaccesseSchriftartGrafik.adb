with Sf.Graphics.Text;

with TextaccessVariablen;

package body TextaccesseSchriftartGrafik is

   procedure SchriftartSetzen
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      -- Ein paar der Sachen zusammenfassen? Oder doch lieber nach Dateien/Bereich getrennt lassen? äöü
      -- Gilt auch für die anderen Bereiche der Textverwaltung. äöü
      Allgemeines (SchriftaccessExtern => SchriftaccessExtern);
      Menüs (SchriftaccessExtern => SchriftaccessExtern);
      Spezies (SchriftaccessExtern => SchriftaccessExtern);
      ZusatztextKartengröße (SchriftaccessExtern => SchriftaccessExtern);
      Sprachauswahl (SchriftaccessExtern => SchriftaccessExtern);
      Kartenformauswahl (SchriftaccessExtern => SchriftaccessExtern);
      StadtInformationen (SchriftaccessExtern => SchriftaccessExtern);
      EinheitenInformationen (SchriftaccessExtern => SchriftaccessExtern);
      KarteWichtiges (SchriftaccessExtern => SchriftaccessExtern);
      KarteAllgemeines (SchriftaccessExtern => SchriftaccessExtern);
      Karte (SchriftaccessExtern => SchriftaccessExtern);
      EinheitStadtAuswahl (SchriftaccessExtern => SchriftaccessExtern);
      AnzeigeEingabe (SchriftaccessExtern => SchriftaccessExtern);
      Ladezeiten (SchriftaccessExtern => SchriftaccessExtern);
      Befehle (SchriftaccessExtern => SchriftaccessExtern);
      
   end SchriftartSetzen;
   
      
   
   procedure Allgemeines
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ÜberschriftAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.VersionsnummerAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZeilenumbruchAccess,
                                font => SchriftaccessExtern);
      
      TexthöhenSchleife:
      for TexthöhenSchleifenwert in TextaccessVariablen.TexthöhenaccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.TexthöhenAccess (TexthöhenSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop TexthöhenSchleife;
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.Spielmeldung,
                                font => SchriftaccessExtern);
                  
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.BildrateAccess,
                                font => SchriftaccessExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.DiplomatieAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenseitenleisteAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.EingabenanzeigeAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenbauinformationenAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudebauinformationenAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtkarteAccess,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtumgebungAccess,
                                font => SchriftaccessExtern);
      -- Später das Zeug überall sortieren. äöü
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => SchriftaccessExtern);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
   
      
   
   procedure Spezies
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                   font => SchriftaccessExtern);
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                   font => SchriftaccessExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccess'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                      font => SchriftaccessExtern);
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                            font => SchriftaccessExtern);
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                      font => SchriftaccessExtern);
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                            font => SchriftaccessExtern);
            end case;
            
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccess'Range (2) loop
         
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                      font => SchriftaccessExtern);
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                      font => SchriftaccessExtern);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.AktuellesBauprojekt,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.AktuellesForschungsprojekt,
                                font => SchriftaccessExtern);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                font => SchriftaccessExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
      
   
   procedure Sprachauswahl
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                font => SchriftaccessExtern);
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                   font => SchriftaccessExtern);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                   font => SchriftaccessExtern);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                   font => SchriftaccessExtern);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                   font => SchriftaccessExtern);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                   font => SchriftaccessExtern);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAccess,
                                font => SchriftaccessExtern);
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                   font => SchriftaccessExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftartGrafik;
