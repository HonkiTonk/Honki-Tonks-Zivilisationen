with LeseWeltkarte;
with LeseEinheitenGebaut;

with AufgabenLogik;
with Fehler;

package body KIEinheitUmsetzenVerbesserungenLogik is

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      WelcheVerbesserung := LeseEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      VorhandeneVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => EinheitKoordinaten);
      
      -- Verhindert das Verbinden von Städten mit Straßen und weiteres. Später eine bessere Lösung bauen. äöü
      if
        LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => EinheitKoordinaten) /= EinheitRasseNummerExtern.Rasse
      then
         return False;
         
      else
         null;
      end if;
      
      -- Aufgaben muss dringend überarbeitet werden. äöü
      -- Diese ganze Aufteilung zwischen AufgabenDatentypen, TastenbelegungDatentypen und KartenverbesserungDatentypen muss mal verbessert werden. äöü
      case
        WelcheVerbesserung
      is
         when AufgabenDatentypen.Mine_Bauen_Enum =>
            Befehl := BefehleDatentypen.Mine_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Mine_Enum
            then
               return False;
               
            elsif
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => BefehleDatentypen.Mine_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            Befehl := BefehleDatentypen.Farm_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Farm_Enum
            then
               return False;
               
            elsif
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => BefehleDatentypen.Farm_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            Befehl := BefehleDatentypen.Festung_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Festung_Enum
            then
               return False;
               
            elsif
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => BefehleDatentypen.Festung_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Straße_Bauen_Enum =>
            Befehl := BefehleDatentypen.Straße_Bauen_Enum;
            
            if
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => BefehleDatentypen.Straße_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIEinheitUmsetzenVerbesserungen.WelcheVerbesserungAnlegen: Falsche Verbesserung: " & WelcheVerbesserung'Wide_Wide_Image);
            return False;
      end case;
      
      return AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    BefehlExtern             => Befehl,
                                    KoordinatenExtern        => EinheitKoordinaten);
      
   end WelcheVerbesserungAnlegen;

end KIEinheitUmsetzenVerbesserungenLogik;
