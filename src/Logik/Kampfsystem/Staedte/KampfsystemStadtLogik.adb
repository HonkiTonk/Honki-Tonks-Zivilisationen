with StadtDatentypen;
with KampfDatentypen;
with SystemDatentypen;
with KampfRecordKonstanten;
with KampfKonstanten;

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

   function KampfwerteErmitteln
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VerteidigerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is
      use type KampfDatentypen.KampfwerteGroß;
      use type KampfDatentypen.Lebenspunkte;
   begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
      then
         return False;
         
      else
         KampfwerteVerteidiger.Verteidigung
           := KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (IDExtern          => LeseStadtGebaut.ID (StadtSpeziesNummerExtern => VerteidigerExtern),
                                                                       KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => VerteidigerExtern),
                                                                       SpeziesExtern     => VerteidigerExtern.Spezies,
                                                                       GebäudeExtern     => LeseStadtGebaut.AlleGebäude (StadtSpeziesNummerExtern => VerteidigerExtern),
                                                                       EinwohnerExtern   => LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigerExtern,
                                                                                                                               EinwohnerArbeiterExtern  => True),
                                                                       TaskExtern        => SystemDatentypen.Logik_Task_Enum);
         
         KampfwerteVerteidiger.Angriff := KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (IDExtern          => LeseStadtGebaut.ID (StadtSpeziesNummerExtern => VerteidigerExtern),
                                                                                               KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => VerteidigerExtern),
                                                                                               SpeziesExtern     => VerteidigerExtern.Spezies,
                                                                                               GebäudeExtern     => LeseStadtGebaut.AlleGebäude (StadtSpeziesNummerExtern => VerteidigerExtern),
                                                                                               EinwohnerExtern   => LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigerExtern,
                                                                                                                                                       EinwohnerArbeiterExtern  => True),
                                                                                               TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
         KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                                                                 TaskExtern                 => SystemDatentypen.Logik_Task_Enum);
         KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                                                       TaskExtern                 => SystemDatentypen.Logik_Task_Enum);
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
         KampfwerteVerteidiger := KampfRecordKonstanten.Sicherheitskampfwerte;
         KampfwerteAngreifer := KampfRecordKonstanten.Sicherheitskampfwerte;
         
      else
         null;
      end if;
      
      return Kampf (AngreiferExtern             => AngreiferExtern,
                    KampfwerteAngreiferExtern   => KampfwerteAngreifer,
                    VerteidigerExtern           => VerteidigerExtern,
                    KampfwerteVerteidigerExtern => KampfwerteVerteidiger);
      
   end KampfwerteErmitteln;
   
   
   
   function Kampf
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is
      use type StadtDatentypen.Einwohner;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      case
        Kampfverlauf (AngreiferExtern             => AngreiferExtern,
                      KampfwerteAngreiferExtern   => KampfwerteAngreiferExtern,
                      VerteidigerExtern           => VerteidigerExtern,
                      KampfwerteVerteidigerExtern => KampfwerteVerteidigerExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      -- Kann man das teilweise mit der Personenänderung im Stadtsystem zusammenführen? äöü
      -- Scheinbar nicht, wenn dann müsste man eines der beiden Systeme anpassen. äöü
      if
        LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigerExtern,
                                           EinwohnerArbeiterExtern  => True)
        - 1
        = StadtKonstanten.LeerEinwohner
      then
         StadtEntfernenLogik.StadtEntfernen (StadtSpeziesNummerExtern => VerteidigerExtern);
         return True;
         
      else
         FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern     => False,
                                                                   StadtSpeziesNummerExtern => VerteidigerExtern);
         MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => VerteidigerExtern,
                                                  EreignisExtern           => StadtDatentypen.Einwohner_Reduktion_Enum);
         if
           LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigerExtern,
                                              EinwohnerArbeiterExtern  => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, VerteidigerExtern.Spezies) - 1
           or
             LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigerExtern,
                                                EinwohnerArbeiterExtern  => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, VerteidigerExtern.Spezies) - 1
         then
            StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtSpeziesNummerExtern => VerteidigerExtern);
            
         else
            null;
         end if;
         
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                  BewegungspunkteExtern      => -2,
                                                  RechnenSetzenExtern        => True);
         
         return False;
      end if;
      
   end Kampf;
   
   
   
   function Kampfverlauf
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
   is
      use type KampfDatentypen.Lebenspunkte;
   begin
      
      GesundheitStadt := Positive (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => VerteidigerExtern,
                                                                      EinwohnerArbeiterExtern  => True));
      
      IDAngreifer := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => AngreiferExtern);
      
      KampfSchleife:
      loop
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteAngreiferExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteVerteidigerExtern.Verteidigung);
         
         if
           Kampfergebnis < KampfKonstanten.KampfverlaufUnentschieden
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                  LebenspunkteExtern         => KampfDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern        => True);
            
         elsif
           Kampfergebnis > KampfKonstanten.KampfverlaufUnentschieden
         then
            GesundheitStadt := GesundheitStadt - Kampfergebnis;
            
         else
            null;
         end if;
         
         if
           GesundheitStadt <= 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern     => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => AngreiferExtern.Spezies,
                                                                                                                                IDExtern      => IDAngreifer),
                                                      AddierenSetzenExtern       => True);
            
            EffektberechnungenLogik.Effektberechnungen (EinheitSpeziesNummerExtern => AngreiferExtern);
            
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => AngreiferExtern);
            return False;

         else
            null;
         end if;
         
         Kampfergebnis := KampfberechnungenLogik.Kampfberechnung (AngriffExtern      => KampfwerteVerteidigerExtern.Angriff,
                                                                  VerteidigungExtern => KampfwerteAngreiferExtern.Verteidigung);
         
         if
           Kampfergebnis < KampfKonstanten.KampfverlaufUnentschieden
         then
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                  LebenspunkteExtern         => KampfDatentypen.Lebenspunkte (Kampfergebnis),
                                                  RechnenSetzenExtern        => True);
            
         elsif
           Kampfergebnis > KampfKonstanten.KampfverlaufUnentschieden
         then
            GesundheitStadt := GesundheitStadt - Kampfergebnis;
            
         else
            null;
         end if;
         
         if
           GesundheitStadt <= 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern     => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => AngreiferExtern.Spezies,
                                                                                                                                IDExtern      => IDAngreifer),
                                                      AddierenSetzenExtern       => True);
            return True;
            
         elsif
           LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => AngreiferExtern) <= EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => AngreiferExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampfverlauf;

end KampfsystemStadtLogik;
