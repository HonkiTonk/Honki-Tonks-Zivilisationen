package AllgemeineBerechnungenHTSEB is
   pragma Pure;

   generic type GanzeZahl is range <>;

   function Basiszeitwert
     (ZusatzwertExtern : in GanzeZahl;
      TeilerExtern : in GanzeZahl)
      return GanzeZahl
     with
       Pre => (
                 ZusatzwertExtern > 0
               and
                 TeilerExtern > 0
              ),

       Post => (
                  Basiszeitwert'Result > 0
               );
   
   function NullprüfungKommazahl
     (KommazahlExtern : in Float)
      return Float
     with
       Post => (
                  NullprüfungKommazahl'Result /= 0.00
               );
   
   function Nullprüfung
     (ZahlExtern : in Integer)
      return Integer
     with
       Post => (
                  Nullprüfung'Result /= 0
               );

end AllgemeineBerechnungenHTSEB;
