package KartenartDatentypen is
   pragma Pure;

   type Kartenart_Enum is (
                           -- Normal
                           Inseln_Enum, Kontinente_Enum, Pangäa_Enum,
                           
                           -- Nutzerdefiniert
                           Nutzerdefiniert_Enum
                          );
   pragma Ordered (Kartenart_Enum);
   
   subtype Kartenart_Normal_Enum is Kartenart_Enum range Inseln_Enum .. Pangäa_Enum;
   
   
   
   type Kartenform_Enum is (
                            Ebene_Übergangslos_Enum, Ebene_Übergang_Enum,
                            Senkrechte_Übergangslos_Enum, Senkrechte_Übergang_Enum, Senkrechte_Rückwärts_Verschobener_Übergang_Enum, Senkrechte_Verschobener_Übergang_Enum,
                            Waagerechte_Übergangslos_Enum, Waagerechte_Übergang_Enum, Waagerechte_Rückwärts_Verschobener_Übergang_Enum, Waagerechte_Verschobener_Übergang_Enum
                           ); 
   pragma Ordered (Kartenform_Enum);
   
   subtype Kartenform_Ebene_Einstellbar_Enum is Kartenform_Enum range Ebene_Übergangslos_Enum .. Ebene_Übergang_Enum;
   subtype Kartenform_Senkrechte_Einstellbar_Enum is Kartenform_Enum range Senkrechte_Übergangslos_Enum .. Senkrechte_Verschobener_Übergang_Enum;
   subtype Kartenform_Waagerechte_Einstellbar_Enum is Kartenform_Enum range Waagerechte_Übergangslos_Enum .. Waagerechte_Verschobener_Übergang_Enum;
   
   
   
   type Kartentemperatur_Enum is (
                                  Eiszeit_Enum, Kalt_Enum, Gemäßigt_Enum, Heiß_Enum, Warmzeit_Enum
                                 );
   pragma Ordered (Kartentemperatur_Enum);
   
   
   
   type Himmelsrichtungen_Enum is (
                                   Norden_Enum, Süden_Enum,
                                   
                                   Westen_Enum, Osten_Enum
                                  );
   
   subtype Senkrechte_Himmelsrichtungen_Enum is Himmelsrichtungen_Enum range Norden_Enum .. Süden_Enum;
   subtype Waagerechte_Himmelsrichtungen_Enum is Himmelsrichtungen_Enum range Westen_Enum .. Osten_Enum;
   
   
   
   type Kartenpole_Enum is (
                            Kartenpol_Nicht_Vorhanden_Enum, Kartenpol_Vorhanden_Enum
                           );
   pragma Ordered (Kartenpole_Enum);

end KartenartDatentypen;
