with EinheitenDatentypen;
with StadtDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with TextKonstanten;
with ProduktionKonstanten;
with Projekteinstellungen;
with SystemDatentypen;
with SpeziesKonstanten;

with KampfwerteStadtErmittelnLogik;
with TextberechnungenHoeheGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with TextaccessverwaltungssystemGrafik;
with AllgemeineBerechnungen;

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
      TextpositionsinformationenExtern : in Sf.System.Vector3.sfVector3f)
      return Sf.System.Vector3.sfVector3f
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Textposition.x := TextpositionsinformationenExtern.x;
      Textposition.y := TextpositionsinformationenExtern.y;
      Textbreite := TextpositionsinformationenExtern.z;
      
      if
        SpeziesExtern = SpeziesKonstanten.LeerSpezies
        or
          StadtauswahlExtern.SpeziesNummer.Spezies = SpeziesKonstanten.LeerSpezies
      then
         TextZeichnen;
         
         return (Textposition.x, Textposition.y, Textbreite);
         
      else
         FestzulegenderText (1) := Spieltexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & StadtauswahlExtern.EinwohnerArbeiter (1)'Wide_Wide_Image;
      end if;
      
      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtauswahlExtern.SpeziesNummer.Spezies = SpeziesExtern
        or
          Projekteinstellungen.Debug.VolleInformation
      then
         FestzulegenderText (2) := Nahrung (ProduktionExtern => StadtauswahlExtern.Nahrungsproduktion,
                                            VorhandenExtern  => StadtauswahlExtern.Nahrungsmittel);
         FestzulegenderText (3) := Spieltexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " " & ZahlAlsString (ZahlExtern => StadtauswahlExtern.Produktionrate);
         FestzulegenderText (4) := Spieltexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " & ZahlAlsString (ZahlExtern => StadtauswahlExtern.Geldgewinnung);
         FestzulegenderText (5) := Spieltexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & StadtauswahlExtern.Forschungsrate'Wide_Wide_Image;
         FestzulegenderText (6) := Kampfwerte (StadtauswahlExtern => StadtauswahlExtern);
         FestzulegenderText (7) := Spieltexte.Zeug (TextnummernKonstanten.ZeugKorruption) & StadtauswahlExtern.Korruption'Wide_Wide_Image;
         FestzulegenderText (8) := Spieltexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & AllgemeineBerechnungen.FreieEinwohner (EinwohnerExtern => StadtauswahlExtern.EinwohnerArbeiter (1),
                                                                                                                                            ArbeiterExtern  => StadtauswahlExtern.EinwohnerArbeiter (2))'Wide_Wide_Image;
         FestzulegenderText (9) := AktuellesBauprojekt (SpeziesExtern    => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                        BauprojektExtern => StadtauswahlExtern.Bauprojekt,
                                                        BauzeitExtern    => StadtauswahlExtern.Bauzeit);
                                 
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
      
      TextZeichnen;
      
      return (Textposition.x, Textposition.y, Textbreite);
      
   end Stadt;
   
   
   
   procedure TextZeichnen
   is begin
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert >= Informationsgrenze
         then
            null;
            
         else
            TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                    TextExtern       => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)),
                                                                    PositionExtern   => Textposition);
                     
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
         end if;
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
   end TextZeichnen;
   
   
   
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
         Text := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauprojektExtern.Gebäude,
                                                                                                         SpeziesExtern => SpeziesExtern));
      
      elsif
        BauprojektExtern.Einheit /= StadtKonstanten.LeerBauprojekt.Einheit
      then
         Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauprojektExtern.Einheit,
                                                                                                          SpeziesExtern => SpeziesExtern));
      
      else
         return TextKonstanten.LeerUnboundedString;
      end if;
      
      case
        BauzeitExtern
      is
         when ProduktionDatentypen.Produktion'Last =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text & TextKonstanten.UnendlichGeklammert;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text & " (" & ZahlAlsString (ZahlExtern => BauzeitExtern) & ")";
      end case;
            
   end AktuellesBauprojekt;
   
end StadtseitenleisteGrafik;
