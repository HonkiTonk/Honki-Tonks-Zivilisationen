with EinheitenKonstanten;
with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseZeiger;
with SchreibeZeiger;

with StadtumgebungErreichbarLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;

package body StadtEinheitenBauenLogik is

   procedure EinheitFertiggestellt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type EinheitenDatentypen.Einheitenbereich;
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
         SchreibeZeiger.KoordinatenAktuell (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                            KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
         SchreibeZeiger.KoordinatenAlt (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                        KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => StadtSpeziesNummerExtern.Spezies));
         
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
   is begin
      
      KartenWert
        := StadtumgebungErreichbarLogik.UmgebungErreichbar (StadtKoordinatenExtern   => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                            StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                            IDExtern                 => EinheitenDatentypen.EinheitenIDVorhanden (LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit));
      
      case
        KartenWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     EreignisExtern           => StadtDatentypen.Einheit_Unplatzierbar_Enum);
            
         when others =>
            EinheitPlatzieren (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               KoordinatenExtern        => KartenWert);
      end case;
      
   end PlatzErmitteln;
   
   
   
   procedure EinheitPlatzieren
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern        => KoordinatenExtern,
                                                       EinheitNummerExtern      => EinheitNummer,
                                                       IDExtern                 => EinheitenDatentypen.EinheitenIDVorhanden (LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit),
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
