package KartenartDatentypen is
   pragma Pure;

   type Kartenart_Enum is (
                           -- Normal
                           Kartenart_Inseln_Enum, Kartenart_Kontinente_Enum, Kartenart_Pangäa_Enum,
                           
                           -- Nutzerdefiniert
                           Kartenart_Nutzerdefiniert_Enum
                          );
   pragma Ordered (Kartenart_Enum);
   
   subtype Kartenart_Normal_Enum is Kartenart_Enum range Kartenart_Inseln_Enum .. Kartenart_Pangäa_Enum;
   
   
   
   type Kartenform_Enum is (
                            Ebene_Übergangslos_Enum, Ebene_Übergang_Enum,
                            Senkrechte_Übergangslos_Enum, Senkrechte_Übergang_Enum, Senkrechte_Rückwärts_Verschobener_Übergang_Enum, Senkrechte_Verschobener_Übergang_Enum,
                            Waagerechte_Übergangslos_Enum, Waagerechte_Übergang_Enum, Waagerechte_Rückwärts_Verschobener_Übergang_Enum, Waagerechte_Verschobener_Übergang_Enum
                           ); 
   pragma Ordered (Kartenform_Enum);
   
   subtype Kartenform_Ebene_Einstellbar_Enum is Kartenform_Enum range Ebene_Übergangslos_Enum .. Ebene_Übergang_Enum;
   subtype Kartenform_Senkrechte_Einstellbar_Enum is Kartenform_Enum range Senkrechte_Übergangslos_Enum .. Senkrechte_Verschobener_Übergang_Enum;
   subtype Kartenform_Waagerechte_Einstellbar_Enum is Kartenform_Enum range Waagerechte_Übergangslos_Enum .. Waagerechte_Verschobener_Übergang_Enum;
   
   
   
   -- Statt eines Enums einen Zahlenwert von 0 bis 100 einbauen. äöü
   -- Hier auch Werte unter 0 zulassen um Eiswelten zu generieren? äöü
   -- Maximalwert unter 100 halten da sonst das Wasser verdampfen würde. äöü
   -- Mal einen eigenen Temperaturwert dafür einbauen. äöü
   type Kartentemperatur_Enum is (
                                  Kartentemperatur_Kalt_Enum, Kartentemperatur_Gemäßigt_Enum, Kartentemperatur_Heiß_Enum, Kartentemperatur_Eiszeit_Enum, Kartentemperatur_Wüste_Enum
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
