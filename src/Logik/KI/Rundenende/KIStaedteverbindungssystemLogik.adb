with StadtKonstanten;
with KartenKonstanten;
with KartenRecordKonstanten;
with AufgabenDatentypen;

with LeseGrenzen;
with LeseStadtGebaut;
with LeseWeltkarte;
with LeseForschungenDatenbank;

with KartenkoordinatenberechnungssystemLogik;
with ForschungstestsLogik;

with KIVariablen;
with KIKonstanten;
with KIDatentypen;

with KIBewegungsbewertungLogik;
with KIAufgabenVerteiltLogik;

package body KIStaedteverbindungssystemLogik is

   -- Eventuell sollte ich speichern welche Städte miteinander verbunden sind, damit diese Prüfungen hier nicht immer wieder durchlaufen müssen. äöü
   -- Wobei natürlich das Problem ist dass die Verbindung ja getrennt werden kann, also müsste ich noch was einbauen dass das dann alle paar Runden prüft. äöü
   procedure Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      case
        -- Lese/Schreibezeug dafür anlegen. äöü
        KIVariablen.Stadtverbindung (SpeziesExtern, KIKonstanten.VerbindungsplanVorhanden).XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            Stadtgrenze := LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern);
            
         when others =>
            return;
      end case;
      
      AnfangsstadtSchleife:
      for AnfangsstadtSchleifenwert in StadtKonstanten.AnfangNummer .. Stadtgrenze loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, AnfangsstadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               KoordinatenAnfangsstadt := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, AnfangsstadtSchleifenwert));
               
               EndstadtSchleife:
               for EndstadtSchleifenwert in StadtKonstanten.AnfangNummer + 1 .. Stadtgrenze loop
            
                  if
                    LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, EndstadtSchleifenwert)) = StadtKonstanten.LeerID
                  then
                     null;
                     
                  elsif
                    False = VerbindungPrüfen (SpeziesExtern          => SpeziesExtern,
                                               StartkoordinatenExtern => KoordinatenAnfangsstadt,
                                               ZielkoordinatenExtern  => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, EndstadtSchleifenwert)))
                  then
                     null;
                     
                  else
                     exit AnfangsstadtSchleife;
                  end if;

               end loop EndstadtSchleife;
         end case;
         
      end loop AnfangsstadtSchleife;
      
   end Stadtverbindung;
   
   
   
   function VerbindungPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StartkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenDatentypen.Ebene;
      use type KartengrundDatentypen.Basisgrund_Enum;
     -- use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      if
        StartkoordinatenExtern.EAchse not in KartenDatentypen.EbenePlanet'Range
        or
          -- Dafür später vielleicht auch Tunnels anlegen? äöü
        StartkoordinatenExtern.EAchse = KartenDatentypen.EbeneVorhanden'First
        or
          StartkoordinatenExtern.EAchse /= ZielkoordinatenExtern.EAchse
      then
         return False;
         
      else
         Startgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => StartkoordinatenExtern);
         Zielgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => ZielkoordinatenExtern);
      end if;
         
      if
        StartkoordinatenExtern.EAchse = KartenKonstanten.OberflächeKonstante
        and
          Startgrund not in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
          and
            Zielgrund not in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
      then
         null;
         
      elsif
        StartkoordinatenExtern.EAchse = KartenKonstanten.UnterflächeKonstante
        and
          Startgrund not in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
          and
            Zielgrund not in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
      then
         null;
         
      else
         return False;
      end if;
      
      case
        PlanenRekursiv (SpeziesExtern              => SpeziesExtern,
                        AktuelleKoordinateExtern   => StartkoordinatenExtern,
                        ZielkoordinatenExtern      => ZielkoordinatenExtern,
                        AktuellePlanpositionExtern => 1)
      is
         when False =>
            return False;
            
         when True =>
            return FelderMitWegEntfernen (SpeziesExtern => SpeziesExtern);
      end case;
      
   end VerbindungPrüfen;
   
   
   
   function PlanenRekursiv
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleKoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is begin
      
      Felderbewertung (SpeziesExtern             => SpeziesExtern,
                       AktuelleKoordinatenExtern => AktuelleKoordinateExtern,
                       ZielkoordinatenExtern     => ZielkoordinatenExtern);
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in BewertungArray'Range loop
         
         case
           PlanschrittFestlegen (SpeziesExtern              => SpeziesExtern,
                                 ZielkoordinatenExtern      => ZielkoordinatenExtern,
                                 DurchlaufExtern            => DurchlaufSchleifenwert,
                                 AktuellePlanpositionExtern => AktuellePlanpositionExtern)
         is
            when True =>
               return True;
               
            when False =>
               KIVariablen.Stadtverbindung (SpeziesExtern, AktuellePlanpositionExtern) := KartenRecordKonstanten.LeerKoordinate;
         end case;
         
      end loop DurchlaufSchleife;
      
      -- Muss ich das überhaupt auf Null setzen? äöü
      -- KIVariablen.Stadtverbindung (SpeziesExtern, Schleifenwert) := KartenRecordKonstanten.LeerKoordinate;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function PlanschrittFestlegen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      -- Muss hier für Windows zwischengespeichert werden, da sonst Bewertung (DurchlaufExtern).Koordinaten in PlanenRekursiv überschrieben wird und als neue AktuelleKoordinatenExtern in der Schleife verwendet wird.
      -- Gilt auch für BewegungsplanLogik und KIBewegungsplanBerechnenLogik.
      -- Passiert nicht unter Linux, eventuell ein Kompilerfehler? Später, erst nach der Veröffentlichung von GNAT 13, mal nachprüfen.
      KoordinatenzwischenspeicherWindows := Bewertung (DurchlaufExtern).Koordinaten;
      
      case
        Bewertung (DurchlaufExtern).Bewertung
      is
         when KartenDatentypen.KartenfeldPositiv'Last =>
            return False;
               
         when KartenDatentypen.KartenfeldNatural'First =>
            KIVariablen.Stadtverbindung (SpeziesExtern, KIKonstanten.VerbindungsplanVorhanden) := ZielkoordinatenExtern;
            return True;
               
         when others =>
            KIVariablen.Stadtverbindung (SpeziesExtern, AktuellePlanpositionExtern) := KoordinatenzwischenspeicherWindows;
            
            if
              AktuellePlanpositionExtern = KIVariablen.Stadtverbindung'Last (2)
            then
               return False;
         
            else
               return PlanenRekursiv (SpeziesExtern              => SpeziesExtern,
                                      AktuelleKoordinateExtern   => KoordinatenzwischenspeicherWindows,
                                      ZielkoordinatenExtern      => ZielkoordinatenExtern,
                                      AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
            end if;
      end case;
      
   end PlanschrittFestlegen;
   
   
   
   procedure Felderbewertung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      BewertungPosition := BewertungArray'First;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
               
            Bewertung (BewertungPosition).Koordinaten := KartenWert;
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
              or
                KartenWert = AktuelleKoordinatenExtern
            then
               Bewertung (BewertungPosition).Bewertung := KartenDatentypen.KartenfeldPositiv'Last;
               
            elsif
              True = FeldUngeeignet (SpeziesExtern     => SpeziesExtern,
                                          KoordinatenExtern => KartenWert)
            then
               Bewertung (BewertungPosition).Bewertung := KartenDatentypen.KartenfeldPositiv'Last;
            
            else
               Bewertung (BewertungPosition).Bewertung := KIBewegungsbewertungLogik.PositionsbewertungKoordinaten (ZielkoordinatenExtern => ZielkoordinatenExtern,
                                                                                                                   NeueKoordinatenExtern => KartenWert);
            end if;
               
            BewertungPosition := BewertungPosition + 1;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
                  
      SortierenEinsSchleife:
      for SortierenEinsSchleifenwert in BewertungArray'Range loop
         SortierenZweiSchleife:
         for SortierenZweiSchleifenwert in SortierenEinsSchleifenwert + 1 .. BewertungArray'Last loop
                           
            if
              Bewertung (SortierenEinsSchleifenwert).Bewertung > Bewertung (SortierenZweiSchleifenwert).Bewertung
            then
               Sortieren := Bewertung (SortierenEinsSchleifenwert);
               Bewertung (SortierenEinsSchleifenwert) := Bewertung (SortierenZweiSchleifenwert);
               Bewertung (SortierenZweiSchleifenwert) := Sortieren;
                  
            else
               null;
            end if;
               
         end loop SortierenZweiSchleife;
      end loop SortierenEinsSchleife;
      
   end Felderbewertung;
   
   
   
   function FeldUngeeignet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      FelderSchleife:
      for FelderSchleifenwert in KIVariablen.StadtverbindungArray'Range (2) loop
         
         if
           KoordinatenExtern = KIVariablen.Stadtverbindung (SpeziesExtern, FelderSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop FelderSchleife;
      
      -- Später auf Wasserwege erweitern. äöü
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern)
      is
         when KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range | KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end FeldUngeeignet;
   
   
   
   function FelderMitWegEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Weg_Enum;
   begin
      
      TechnologieVorhanden := ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                         TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern     => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                                                                                             SpeziesExtern => SpeziesExtern));
      
      VerbindungSchleife:
      for VerbindungSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'Range loop
         
         if
           KIVariablen.Stadtverbindung (SpeziesExtern, VerbindungSchleifenwert).XAchse = KartenKonstanten.LeerXAchse
         then
            null;
            
         elsif
           True = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                              SpeziesExtern         => SpeziesExtern,
                                                              ZielKoordinatenExtern => KIVariablen.Stadtverbindung (SpeziesExtern, VerbindungSchleifenwert))
         then
            KIVariablen.Stadtverbindung (SpeziesExtern, VerbindungSchleifenwert) := KartenRecordKonstanten.LeerKoordinate;
               
         else
            VorhandenerWeg := LeseWeltkarte.Weg (KoordinatenExtern => KIVariablen.Stadtverbindung (SpeziesExtern, VerbindungSchleifenwert));
                             
            if
              VorhandenerWeg = KartenverbesserungDatentypen.Leer_Weg_Enum
            then
               null;
         
            elsif
              VorhandenerWeg in KartenverbesserungDatentypen.Straße_Enum'Range
              and
                TechnologieVorhanden
            then
               null;
            
            else
               KIVariablen.Stadtverbindung (SpeziesExtern, VerbindungSchleifenwert) := KartenRecordKonstanten.LeerKoordinate;
            end if;
         end if;
         
      end loop VerbindungSchleife;
      
      return VerbindungLeeren (SpeziesExtern => SpeziesExtern);
      
   end FelderMitWegEntfernen;
   
   
   
   procedure ElementEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ElementExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
   is begin
      
      KIVariablen.Stadtverbindung (SpeziesExtern, ElementExtern) := KartenRecordKonstanten.LeerKoordinate;
      
      Leerwert := VerbindungLeeren (SpeziesExtern => SpeziesExtern);
      
   end ElementEntfernen;
   
   
   
   function VerbindungLeeren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      VerbindungSchleife:
      for VerbindungSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'Range loop
         
         if
           KIVariablen.Stadtverbindung (SpeziesExtern, VerbindungSchleifenwert) = KartenRecordKonstanten.LeerKoordinate
         then
            null;
            
         else
            return True;
         end if;
         
      end loop VerbindungSchleife;
      
      KIVariablen.Stadtverbindung (SpeziesExtern, KIKonstanten.VerbindungsplanVorhanden) := KartenRecordKonstanten.LeerKoordinate;
      
      return False;
      
   end VerbindungLeeren;

end KIStaedteverbindungssystemLogik;
