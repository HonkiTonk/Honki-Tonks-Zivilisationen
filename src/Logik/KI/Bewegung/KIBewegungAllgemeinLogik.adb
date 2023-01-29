with DiplomatieDatentypen;
with EinheitenDatentypen;
with AufgabenDatentypen;
with SpeziesKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseDiplomatie;

with EinheitSuchenLogik;
with StadtSuchenLogik;

with KIKonstanten;

package body KIBewegungAllgemeinLogik is

   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      BlockierendeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => FeldKoordinatenExtern,
                                                                                     LogikGrafikExtern => True);
      BlockierendeStadt := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => FeldKoordinatenExtern).Spezies;
      
      if
        BlockierendeEinheit.Spezies = SpeziesKonstanten.LeerSpezies
        and
          BlockierendeStadt = SpeziesKonstanten.LeerSpezies
      then
         return KIKonstanten.BewegungNormal;
         
      elsif
        BlockierendeEinheit.Spezies = EinheitSpeziesNummerExtern.Spezies
      then
         Aufgabe := LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
         if
           LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = AufgabenDatentypen.Leer_Aufgabe_Enum
           and
             (Aufgabe = KIDatentypen.Leer_Aufgabe_Enum
              or
                Aufgabe = KIDatentypen.Platz_Machen_Enum
              or
                Aufgabe = KIDatentypen.Einheit_Auflösen_Enum
              or
                Aufgabe = KIDatentypen.Erkunden_Enum)
         then
            -- return KIKonstanten.Tauschbewegung;
            return KIKonstanten.KeineBewegung;
            
         else
            return KIKonstanten.KeineBewegung;
         end if;
         
      elsif
        BlockierendeStadt = EinheitSpeziesNummerExtern.Spezies
      then
         return KIKonstanten.BewegungNormal;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return KIKonstanten.KeineBewegung;
            
         when others =>
            return FeldAngreifen (EigeneEinheitExtern            => EinheitSpeziesNummerExtern,
                                  FeindlicheSpeziesEinheitExtern => BlockierendeEinheit.Spezies,
                                  FeindlicheSpeziesStadtExtern   => BlockierendeStadt);
      end case;
      
   end FeldBetreten;
   
   
   
   -- Hier nochmal besser unterscheiden mit was angegeriffen wird? äöü
   function FeldAngreifen
     (EigeneEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FeindlicheSpeziesEinheitExtern : in SpeziesDatentypen.Spezies_Enum;
      FeindlicheSpeziesStadtExtern : in SpeziesDatentypen.Spezies_Enum)
      return KIDatentypen.Bewegung_Enum
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        FeindlicheSpeziesEinheitExtern = SpeziesKonstanten.LeerSpezies
        and then
          DiplomatieDatentypen.Krieg_Enum /= LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => EigeneEinheitExtern.Spezies,
                                                                              SpeziesZweiExtern => FeindlicheSpeziesStadtExtern)
      then
         return KIKonstanten.KeineBewegung;
         
      elsif
        FeindlicheSpeziesStadtExtern = SpeziesKonstanten.LeerSpezies
        and then
          DiplomatieDatentypen.Krieg_Enum /= LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => EigeneEinheitExtern.Spezies,
                                                                              SpeziesZweiExtern => FeindlicheSpeziesEinheitExtern)
      then
         return KIKonstanten.KeineBewegung;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EigeneEinheitExtern)
      is
         when KIDatentypen.Angreifen_Enum | KIDatentypen.Verbesserung_Zerstören_Enum | KIDatentypen.Erkunden_Enum | KIDatentypen.Verteidigen_Enum =>
            return KIKonstanten.BewegungAngriff;
            
         when others =>
            return KIKonstanten.KeineBewegung;
      end case;
      
   end FeldAngreifen;

end KIBewegungAllgemeinLogik;
