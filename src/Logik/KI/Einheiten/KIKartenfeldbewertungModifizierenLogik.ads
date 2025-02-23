with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package KIKartenfeldbewertungModifizierenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function StadtabstandVorhanden
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
      
   GuteFelder : Float;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;

   type KartenfeldBewertungStadtBauenMinimumArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Float;
   KartenfeldBewertungStadtBauenMinimum : constant KartenfeldBewertungStadtBauenMinimumArray := (
                                                                                                 SpeziesDatentypen.Menschen_Enum         => 10.00,
                                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => 10.00,
                                                                                                 SpeziesDatentypen.Lasupin_Enum          => 10.00,
                                                                                                 SpeziesDatentypen.Lamustra_Enum         => 10.00,
                                                                                                 SpeziesDatentypen.Manuky_Enum           => 10.00,
                                                                                                 SpeziesDatentypen.Suroka_Enum           => 10.00,
                                                                                                 SpeziesDatentypen.Pryolon_Enum          => 10.00,
                                                                                                 SpeziesDatentypen.Talbidahr_Enum        => 10.00,
                                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => 10.00,
                                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => 10.00,
                                                                                                 SpeziesDatentypen.Carupex_Enum          => 10.00,
                                                                                                 SpeziesDatentypen.Alary_Enum            => 10.00,
                                                                                                 SpeziesDatentypen.Tesorahn_Enum         => 10.00,
                                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => 10.00,
                                                                                                 SpeziesDatentypen.Tridatus_Enum         => 10.00,
                                                                                                 SpeziesDatentypen.Senelari_Enum         => 10.00,
                                                                                                 SpeziesDatentypen.Aspari_2_Enum         => 10.00,
                                                                                                 SpeziesDatentypen.Ekropa_Enum           => 10.00
                                                                                                );
   
   
      
   function GutGenug
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KIKartenfeldbewertungModifizierenLogik;
