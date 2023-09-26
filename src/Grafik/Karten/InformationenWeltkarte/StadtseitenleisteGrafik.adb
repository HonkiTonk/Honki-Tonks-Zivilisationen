with EinheitenDatentypen;
with StadtDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with TextKonstanten;
with ProduktionKonstanten;
with Projekteinstellungen;
with SystemDatentypen;
with SpeziesKonstanten;
with GrafikRecordKonstanten;

with KampfwerteStadtErmittelnLogik;
with TextberechnungenHoeheGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with TextaccessverwaltungssystemGrafik;
with AllgemeineBerechnungen;
with TextskalierungGrafik;

package body StadtseitenleisteGrafik is
   
   procedure Stadtinformationen
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
   is begin
      
      null;
      
      -- Stadt (SpeziesExtern        => StadtauswahlExtern.SpeziesNummer.Spezies,
      --        StadtauswahlExtern   => StadtauswahlExtern,
      --       AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtInformationen),
      --       ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtInformationen));
      
   end Stadtinformationen;
   
   

   function Stadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord;
      TextpositionsinformationenExtern : in GrafikRecords.TextpositionLeerzeilenRecord;
      MaximaleTextbreiteExtern : in Float)
      return GrafikRecords.TextpositionLeerzeilenRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Textposition.x := TextpositionsinformationenExtern.Textpositionsinformationen.x;
      Textposition.y := TextpositionsinformationenExtern.Textpositionsinformationen.y;
      Textbreite := TextpositionsinformationenExtern.Textpositionsinformationen.z;
      Leerzeilen := TextpositionsinformationenExtern.Leerzeilen;
      
      if
        SpeziesExtern = SpeziesKonstanten.LeerSpezies
        or
          StadtauswahlExtern.SpeziesNummer.Spezies = SpeziesKonstanten.LeerSpezies
      then
         AnzuzeigenderText := (others => TextKonstanten.LeerUnboundedString);
         
      else
         AnzuzeigenderText (1) := Spieltexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & StadtauswahlExtern.EinwohnerArbeiter (1)'Wide_Wide_Image;
         
         if
           StadtauswahlExtern.SpeziesNummer.Spezies = SpeziesExtern
           or
             Projekteinstellungen.Debug.VolleInformation
         then
            AnzuzeigenderText (2) := Nahrung (ProduktionExtern => StadtauswahlExtern.Nahrungsproduktion,
                                              VorhandenExtern  => StadtauswahlExtern.Nahrungsmittel);
            AnzuzeigenderText (3) := Spieltexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " " & ZahlAlsString (ZahlExtern => StadtauswahlExtern.Produktionrate);
            AnzuzeigenderText (4) := Spieltexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " & ZahlAlsString (ZahlExtern => StadtauswahlExtern.Geldgewinnung);
            AnzuzeigenderText (5) := Spieltexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & StadtauswahlExtern.Forschungsrate'Wide_Wide_Image;
            AnzuzeigenderText (6) := Kampfwerte (StadtauswahlExtern => StadtauswahlExtern);
            AnzuzeigenderText (7) := Spieltexte.Zeug (TextnummernKonstanten.ZeugKorruption) & StadtauswahlExtern.Korruption'Wide_Wide_Image;
            AnzuzeigenderText (8) := Spieltexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & AllgemeineBerechnungen.FreieEinwohner (EinwohnerExtern => StadtauswahlExtern.EinwohnerArbeiter (1),
                                                                                                                                              ArbeiterExtern  => StadtauswahlExtern.EinwohnerArbeiter (2))'Wide_Wide_Image;
            AnzuzeigenderText (9) := AktuellesBauprojekt (SpeziesExtern    => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                          BauprojektExtern => StadtauswahlExtern.Bauprojekt,
                                                          BauzeitExtern    => StadtauswahlExtern.Bauzeit);

         else
            AnzuzeigenderText (2 .. 9) := (others => TextKonstanten.LeerUnboundedString);
         end if;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         if
           AnzuzeigenderText (TextSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Leerzeilen := Leerzeilen + 1;
            
         else
            TextaccessverwaltungssystemGrafik.TextPosition (TextaccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                            TextExtern       => To_Wide_Wide_String (Source => AnzuzeigenderText (TextSchleifenwert)),
                                                            PositionExtern   => Textposition);
            
            Textbreite := TextberechnungenBreiteGrafik.TextbreiteAnfangsabstand (TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                                 AbstandExtern    => 2.00 * TextberechnungenBreiteGrafik.KleinerSpaltenabstand);
            
            Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                                ErlaubteBreiteExtern => MaximaleTextbreiteExtern);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
                        
            TextaccessverwaltungssystemGrafik.SkalierenZeichnen (TextaccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                 SkalierungExtern => Skalierung);
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end if;
         
      end loop TextSchleife;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      return ((Textposition.x, Textposition.y, Textbreite), Leerzeilen);
      
   end Stadt;
   
   
   
   function Nahrung
     (ProduktionExtern : in ProduktionDatentypen.Stadtproduktion;
      VorhandenExtern : in ProduktionDatentypen.Stadtproduktion)
      return Unbounded_Wide_Wide_String
   is
      use type ProduktionDatentypen.Produktion;
   begin
            
      if
        ProduktionExtern = ProduktionKonstanten.LeerProduktion
      then
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & VorhandenExtern'Wide_Wide_Image;
         
      elsif
        ProduktionExtern > ProduktionKonstanten.LeerProduktion
      then
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & VorhandenExtern'Wide_Wide_Image & TextKonstanten.StandardAbstand & "+" & ZahlAlsString (ZahlExtern => ProduktionExtern);
         
      else
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & VorhandenExtern'Wide_Wide_Image & TextKonstanten.StandardAbstand & ZahlAlsString (ZahlExtern => ProduktionExtern);
      end if;
      
   end Nahrung;
   
   
   
   function Kampfwerte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
      return Unbounded_Wide_Wide_String
   is begin
               
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (IDExtern          => StadtauswahlExtern.ID,
                                                                                                                           KoordinatenExtern => StadtauswahlExtern.Koordinaten,
                                                                                                                           SpeziesExtern     => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                                                                                           GebäudeExtern     => StadtauswahlExtern.GebäudeVorhanden,
                                                                                                                           EinwohnerExtern   => StadtauswahlExtern.EinwohnerArbeiter (1),
                                                                                                                           TaskExtern        => SystemDatentypen.Grafik_Task_Enum)'Wide_Wide_Image
        & " " & TextKonstanten.TrennzeichenUnterschiedlich & KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (IDExtern          => StadtauswahlExtern.ID,
                                                                                                                      KoordinatenExtern => StadtauswahlExtern.Koordinaten,
                                                                                                                      SpeziesExtern     => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                                                                                      GebäudeExtern     => StadtauswahlExtern.GebäudeVorhanden,
                                                                                                                      EinwohnerExtern   => StadtauswahlExtern.EinwohnerArbeiter (1),
                                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum)'Wide_Wide_Image;
      
   end Kampfwerte;
   
   
   
   function AktuellesBauprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BauprojektExtern : in StadtRecords.BauprojektRecord;
      BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Unbounded_Wide_Wide_String
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      if
        BauprojektExtern.Gebäude /= StadtKonstanten.LeerBauprojekt.Gebäude
      then
         Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauprojektExtern.Gebäude,
                                                                                                                     SpeziesExtern => SpeziesExtern));
      
      elsif
        BauprojektExtern.Einheit /= StadtKonstanten.LeerBauprojekt.Einheit
      then
         Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauprojektExtern.Einheit,
                                                                                                                      SpeziesExtern => SpeziesExtern));
      
      else
         return TextKonstanten.LeerUnboundedString;
      end if;
      
      case
        BauzeitExtern
      is
         when ProduktionDatentypen.Produktion'Last =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Zwischenspeicher & TextKonstanten.UnendlichGeklammert;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Zwischenspeicher & " (" & ZahlAlsString (ZahlExtern => BauzeitExtern) & ")";
      end case;
            
   end AktuellesBauprojekt;
   
end StadtseitenleisteGrafik;
