with ProduktionDatentypen;
with KampfDatentypen;
with SystemDatentypen;
with StadtDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with StadtEntfernenLogik;
with KampfwerteStadtErmittelnLogik;
with KampfwerteEinheitErmittelnLogik;
with StadtumgebungFestlegenLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;
with KampfberechnungenLogik;
with FelderbewirtschaftungLogik;
with EffektberechnungenLogik;

package body KampfsystemStadtLogik is

   function KampfsystemStadt
     (AngreifendeEinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VerteidigendeStadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is
      use type KampfDatentypen.KampfwerteGroß;
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern) <= EinheitenKonstanten.LeerLebenspunkte
      then
         return False;
         
      else
         KampfwerteVerteidiger.Verteidigung := KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (IDExtern          => LeseStadtGebaut.ID (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern),
                                                                                                        KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern),
                                                                                                        SpeziesExtern     => VerteidigendeStadtSpeziesNummerExtern.Spezies,
                                                                                                        GebäudeExtern     => LeseStadtGebaut.AlleGebäude (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern));
         KampfwerteVerteidiger.Angriff := KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (IDExtern          => LeseStadtGebaut.ID (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern),
                                                                                               KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern),
                                                                                               SpeziesExtern     => VerteidigendeStadtSpeziesNummerExtern.Spezies,
                                                                                               GebäudeExtern     => LeseStadtGebaut.AlleGebäude (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern));
      
         KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                                                                 LogikGrafikExtern          => True);
         KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                                                       LogikGrafikExtern          => True);
      end if;
      
      if
        KampfwerteVerteidiger.Verteidigung = EinheitenKonstanten.LeerVerteidigung
        and
          KampfwerteVerteidiger.Angriff = EinheitenKonstanten.LeerAngriff
          and
            KampfwerteAngreifer.Verteidigung = EinheitenKonstanten.LeerVerteidigung
            and
              KampfwerteAngreifer.Angriff = EinheitenKonstanten.LeerAngriff
      then
         KampfwerteVerteidiger := (1, 1);
         KampfwerteAngreifer := (1, 1);
         
      else
         null;
      end if;
      
      return Kampf (AngreifendeEinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                    KampfwerteAngreiferExtern             => KampfwerteAngreifer,
                    VerteidigendeStadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                    KampfwerteVerteidigerExtern           => KampfwerteVerteidiger);
      
   end KampfsystemStadt;
   
   
   
   function Kampf
     (AngreifendeEinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is
      use type ProduktionDatentypen.Einwohner;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      case
        Kampfverlauf (AngreifendeEinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                      KampfwerteAngreiferExtern             => KampfwerteAngreiferExtern,
                      VerteidigendeStadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                      KampfwerteVerteidigerExtern           => KampfwerteVerteidigerExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      -- Kann man das teilweise mit der Personenänderung im Stadtsystem zusammenführen? äöü
      -- Scheinbar nicht, wenn dann müsste man eines der beiden Systeme anpassen. äöü
      if
        LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                                           EinwohnerArbeiterExtern  => True)
        - 1
        <= StadtKonstanten.LeerEinwohner
      then
         StadtEntfernenLogik.StadtEntfernen (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern);
         return True;
         
      else
         FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern     => False,
                                                                   StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern);
         MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                                                  EreignisExtern           => StadtDatentypen.Einwohner_Reduktion_Enum);
         if
           LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                                              EinwohnerArbeiterExtern  => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, VerteidigendeStadtSpeziesNummerExtern.Spezies) - 1
           or
             LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                                                EinwohnerArbeiterExtern  => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, VerteidigendeStadtSpeziesNummerExtern.Spezies) - 1
         then
            StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern);
            
         else
            null;
         end if;
         
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                  BewegungspunkteExtern      => -2,
                                                  RechnenSetzenExtern        => True);
         
         return False;
      end if;
      
   end Kampf;
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      GesundheitStadt := Positive (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigendeStadtSpeziesNummerExtern,
                                                                      EinwohnerArbeiterExtern  => True));
      
      IDAngreifer := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern);
      
      KampfSchleife:
      loop
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteAngreiferExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteVerteidigerExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                  LebenspunkteExtern         => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern        => True);
            
         elsif
           Kampfergebnis > 0
         then
            GesundheitStadt := GesundheitStadt - Kampfergebnis;
            
         else
            null;
         end if;
         
         if
           GesundheitStadt <= 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                      ErfahrungspunkteExtern     => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies,
                                                                                                                                IDExtern      => IDAngreifer),
                                                      AddierenSetzenExtern       => True);
            
            EffektberechnungenLogik.Effektberechnungen (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern);
            
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern);
            return False;

         else
            null;
         end if;
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteVerteidigerExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteAngreiferExtern.Verteidigung);
         
         if
           Kampfergebnis < 0
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                  LebenspunkteExtern         => EinheitenDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern        => True);
            
         elsif
           Kampfergebnis > 0
         then
            GesundheitStadt := GesundheitStadt - Kampfergebnis;
            
         else
            null;
         end if;
         
         if
           GesundheitStadt <= 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern,
                                                      ErfahrungspunkteExtern     => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies,
                                                                                                                                IDExtern      => IDAngreifer),
                                                      AddierenSetzenExtern       => True);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => AngreifendeEinheitSpeziesNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampfverlauf;

end KampfsystemStadtLogik;
