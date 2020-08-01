FROM alpine:3.12

COPY ./entrypoint.sh ./

ENTRYPOINT ["/entrypoint.sh"]
CMD ["check"] 