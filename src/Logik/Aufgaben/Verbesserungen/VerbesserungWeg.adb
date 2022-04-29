pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with AufgabenAllgemein;
with Fehler;

package body VerbesserungWeg is
   
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin

      -------------------------- Das für alle Arbeiten vornehmen.
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            if
              OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
            
         when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
            if
              OberflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            if
              UnterflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            if
              UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      return True;
      
   end VerbesserungWeg;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return Boolean
   is begin
      
      WegVorhanden := LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        WegVorhanden
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range =>
            null;
            
         when KartenVerbesserungDatentypen.Karten_Schiene_Enum'Range =>
            null;
            
         when KartenVerbesserungDatentypen.Karten_Tunnel_Enum'Range =>
            null;
            
         when others =>
            null;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Hügel_Enum
            | KartengrundDatentypen.Wald_Enum =>
            if
              LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            in
              KartenVerbesserungDatentypen.Karten_Straße_Enum'Range
            then
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => AufgabenDatentypen.Schiene_Bauen_Enum);

            else
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => AufgabenDatentypen.Straße_Bauen_Enum);
            end if;

            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartengrundDatentypen.Gebirge_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => AufgabenDatentypen.Straße_Bauen_Enum);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 6,
                                                         RechnenSetzenExtern      => 0);

         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "VerbesserungWeg.OberflächeLand - Falscher Kartengrund.");
      end case;
      
      return True;
   
   end OberflächeLand;

     
     
   function OberflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum)
      return Boolean
   is begin
      
      if
        EinheitRasseNummerExtern.Platznummer = 1
        and
          GrundExtern = KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'First
      then
         null;
         
      else
         null;
      end if;
     
      return True;
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return Boolean
   is begin
      
      if
        EinheitRasseNummerExtern.Platznummer = 1
        and
          GrundExtern = KartengrundDatentypen.Kartengrund_Unterfläche_Enum'First
      then
         null;
         
      else
         null;
      end if;
     
      return True;
   
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return Boolean
   is begin
      
      if
        EinheitRasseNummerExtern.Platznummer = 1
        and
          GrundExtern = KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'First
      then
         null;
         
      else
         null;
      end if;
     
      return True;
   
   end UnterflächeWasser;

end VerbesserungWeg;
