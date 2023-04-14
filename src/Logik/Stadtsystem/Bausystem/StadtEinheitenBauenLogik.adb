with EinheitenKonstanten;
with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseCursor;
with SchreibeCursor;

with EinheitSuchenLogik;
with StadtumgebungErreichbarLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;

package body StadtEinheitenBauenLogik is

   procedure EinheitFertiggestellt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) loop
            
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               EinheitNummer := EinheitNummerSchleifenwert;
               exit EinheitenSchleife;
            
            when others =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
        and
          LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
      then
         SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                            KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
         SchreibeCursor.KoordinatenAlt (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                        KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => StadtSpeziesNummerExtern.Spezies));
         
      elsif
        EinheitNummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      else
         PlatzErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end if;
      
   end EinheitFertiggestellt;
   
   
   
   procedure PlatzErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                                                                 LogikGrafikExtern => True).Nummer
      then
         KartenWert := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         
      else
         KartenWert :=
           StadtumgebungErreichbarLogik.UmgebungErreichbar (AktuelleKoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                            SpeziesExtern             => StadtSpeziesNummerExtern.Spezies,
                                                            IDExtern                  => EinheitenDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit),
                                                            NotwendigeFelderExtern    => 1);
      end if;
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     EreignisExtern           => StadtDatentypen.Einheit_Unplatzierbar_Enum);
            
         when others =>
            EinheitPlatzieren (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               KoordinatenExtern        => KartenWert);
      end case;
      
   end PlatzErmitteln;
   
   
   
   procedure EinheitPlatzieren
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern        => KoordinatenExtern,
                                                       EinheitNummerExtern      => EinheitNummer,
                                                       IDExtern                 => EinheitenDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit),
                                                       StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                    MaterialExtern           => StadtKonstanten.LeerMaterial,
                                    ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      BauprojektExtern         => StadtKonstanten.LeerBauprojekt);
            
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     EreignisExtern           => StadtDatentypen.Produktion_Abgeschlossen_Enum);
         
         when others =>
            SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                  BeschäftigungExtern      => KIDatentypen.Keine_Aufgabe_Enum);
      end case;
      
   end EinheitPlatzieren;

end StadtEinheitenBauenLogik;
