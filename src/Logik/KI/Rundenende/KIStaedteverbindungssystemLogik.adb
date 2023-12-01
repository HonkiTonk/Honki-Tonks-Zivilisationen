with StadtKonstanten;
with KartenKonstanten;
with KartenRecordKonstanten;
with AufgabenDatentypen;
with SystemDatentypen;

with LeseGrenzen;
with LeseStadtGebaut;
with LeseWeltkarte;
with LeseForschungenDatenbank;

with KartenkoordinatenberechnungssystemLogik;
with ForschungstestsLogik;

with KIKonstanten;
with KIDatentypen;
with KIVariablen;

with LeseKIVariablen;
with SchreibeKIVariablen;

with KIBewegungsbewertungLogik;
with KIAufgabenVerteiltLogik;

package body KIStaedteverbindungssystemLogik is

   -- Eventuell sollte ich speichern welche Städte miteinander verbunden sind, damit diese Prüfungen hier nicht immer wieder durchlaufen müssen. äöü
   -- Wobei natürlich das Problem ist dass die Verbindung ja getrennt werden kann, also müsste ich noch was einbauen dass das dann alle paar Runden prüft. äöü
   -- Beziehungsweise müsste es nach jeder Plünderun geprüft werden, wobei ich bei der Plünderung prüfen könnte ob da ein Weg zerstört wird und nur dann die Verbundenheit von Städten ernuet prüfen. äöü
   procedure Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type StadtDatentypen.Städtebereich;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      case
        LeseKIVariablen.Stadtverbindung (SpeziesExtern   => SpeziesExtern,
                                         AbschnittExtern => KIKonstanten.VerbindungsplanVorhanden).XAchse
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
               exit AnfangsstadtSchleife;
               
            when others =>
               KoordinatenAnfangsstadt := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, AnfangsstadtSchleifenwert));
               
               EndstadtSchleife:
               for EndstadtSchleifenwert in StadtKonstanten.AnfangNummer + 1 .. Stadtgrenze loop
            
                  if
                    LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, EndstadtSchleifenwert)) = StadtKonstanten.LeerID
                  then
                     exit EndstadtSchleife;
                     
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
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
               SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                                    AbschnittExtern   => AktuellePlanpositionExtern,
                                                    KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function PlanschrittFestlegen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
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
            SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                                 AbschnittExtern   => KIKonstanten.VerbindungsplanVorhanden,
                                                 KoordinatenExtern => ZielkoordinatenExtern);
            return True;
               
         when others =>
            SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                                 AbschnittExtern   => AktuellePlanpositionExtern,
                                                 KoordinatenExtern => KoordinatenzwischenspeicherWindows);
            
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
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
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      FelderSchleife:
      for FelderSchleifenwert in KIVariablen.StadtverbindungArray'Range (2) loop
         
         if
           KoordinatenExtern = LeseKIVariablen.Stadtverbindung (SpeziesExtern   => SpeziesExtern,
                                                                AbschnittExtern => FelderSchleifenwert)
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
           KartenKonstanten.LeerXAchse = LeseKIVariablen.Stadtverbindung (SpeziesExtern   => SpeziesExtern,
                                                                          AbschnittExtern => VerbindungSchleifenwert).XAchse
         then
            null;
            
         elsif
           True = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                              SpeziesExtern         => SpeziesExtern,
                                                              ZielKoordinatenExtern => LeseKIVariablen.Stadtverbindung (SpeziesExtern   => SpeziesExtern,
                                                                                                                        AbschnittExtern => VerbindungSchleifenwert))
         then
            SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                                 AbschnittExtern   => VerbindungSchleifenwert,
                                                 KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
               
         else
            VorhandenerWeg := LeseWeltkarte.Weg (KoordinatenExtern => LeseKIVariablen.Stadtverbindung (SpeziesExtern   => SpeziesExtern,
                                                                                                       AbschnittExtern => VerbindungSchleifenwert));
                             
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
               SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                                    AbschnittExtern   => VerbindungSchleifenwert,
                                                    KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
            end if;
         end if;
         
      end loop VerbindungSchleife;
      
      return VerbindungLeeren (SpeziesExtern => SpeziesExtern);
      
   end FelderMitWegEntfernen;
   
   
   
   procedure ElementEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ElementExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
   is begin
      
      SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                           AbschnittExtern   => ElementExtern,
                                           KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
      
      Leerwert := VerbindungLeeren (SpeziesExtern => SpeziesExtern);
      
   end ElementEntfernen;
   
   
   
   function VerbindungLeeren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      VerbindungSchleife:
      for VerbindungSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'Range loop
         
         if
           KartenRecordKonstanten.LeerKoordinate = LeseKIVariablen.Stadtverbindung (SpeziesExtern   => SpeziesExtern,
                                                                                    AbschnittExtern => VerbindungSchleifenwert)
         then
            null;
            
         else
            return True;
         end if;
         
      end loop VerbindungSchleife;
      
      
      SchreibeKIVariablen.Stadtverbindung (SpeziesExtern     => SpeziesExtern,
                                           AbschnittExtern   => KIKonstanten.VerbindungsplanVorhanden,
                                           KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
      
      return False;
      
   end VerbindungLeeren;

end KIStaedteverbindungssystemLogik;
