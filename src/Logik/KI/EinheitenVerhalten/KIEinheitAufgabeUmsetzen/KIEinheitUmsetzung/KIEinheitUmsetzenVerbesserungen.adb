pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;

with AufgabenLogik;
with Fehler;

package body KIEinheitUmsetzenVerbesserungen is

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      WelcheVerbesserung := LeseEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      VorhandeneVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => EinheitKoordinaten);
      
      -- Verhindert das Verbinden von Städten mit Straßen und weiteres. Später eine bessere Lösung bauen. äöü
      if
        LeseKarten.RasseBelegtGrund (KoordinatenExtern => EinheitKoordinaten) /= EinheitRasseNummerExtern.Rasse
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
            Befehl := TastenbelegungDatentypen.Mine_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Mine_Enum
            then
               return False;
               
            elsif
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Mine_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Farm_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Farm_Enum
            then
               return False;
               
            elsif
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Farm_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Festung_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Festung_Enum
            then
               return False;
               
            elsif
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Festung_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Straße_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Straße_Bauen_Enum;
            
            if
              True = AufgabenLogik.AufgabeTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Straße_Bauen_Enum,
                                                  KoordinatenExtern        => EinheitKoordinaten)
            then
               null;
               
            else
               return False;
            end if;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIEinheitUmsetzenVerbesserungen.WelcheVerbesserungAnlegen - Falsche Verbesserung ausgewählt.");
            return False;
      end case;
      
      return AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    BefehlExtern             => Befehl,
                                    KoordinatenExtern        => EinheitKoordinaten);
      
   end WelcheVerbesserungAnlegen;

end KIEinheitUmsetzenVerbesserungen;
