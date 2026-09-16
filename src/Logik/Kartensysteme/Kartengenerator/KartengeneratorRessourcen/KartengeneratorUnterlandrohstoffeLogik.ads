private with SystemDatentypenHTSEB;

with KartenDatentypen;
with KartenRecords;

private with KartenrohstoffeDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorUnterlandrohstoffeLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure KartengeneratorUnterlandrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcheRohstoff : KartenrohstoffeDatentypen.Rohstoffe_Enum;

   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;



   function RohstoffZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungKohle
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungEisen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungÖl
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungHochwertigerBoden
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function ZusatzberechnungGold
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Unterfläche_Land_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorUnterlandrohstoffeLogik;
